import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/booking/booking_repository_firebase.dart';
import 'package:jis_kong/data/repositories/user/user_repository_firebase.dart';
import '../../../../model/booking/booking.dart';

class MyRideViewModel extends ChangeNotifier {
  final BookingRepositoryFirebase _bookingRepo;
  final UserRepositoryFirebase _userRepo;

  List<Booking> _userBookings = [];
  bool _isLoading = false;
  Timer? _timer;
  Duration _rideDuration = Duration.zero;

  final String activeBookingStatus = "No Active Bookings";
  final String bookingSubtitle = "Find a station and book your next ride!";

  MyRideViewModel(this._bookingRepo, this._userRepo);

  List<Booking> get userBookings => _userBookings;
  bool get isLoading => _isLoading;

  List<Booking> get activeBookings => _userBookings
      .where(
        (b) => b.status == Status.Booking,
      )
      .toList();

  List<Booking> get recentBookings => _userBookings
      .where(
        (b) => b.status != Status.Booking,
      )
      .toList();

  Duration get rideDuration => _rideDuration;

  void startTimer(DateTime startTime) {
    if (_timer != null) return;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _rideDuration = DateTime.now().difference(startTime);
      notifyListeners();
    });
  }

  Booking? get activeBooking {
    try {
      return _userBookings.firstWhere((b) => b.status == Status.Booking);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(_rideDuration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(_rideDuration.inSeconds.remainder(60));
    return "${twoDigits(_rideDuration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> loadRides(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _userBookings = await _bookingRepo.getUserBookings(userId);
    } catch (e) {
      debugPrint("Firebase Booking Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> completeBooking(Booking booking) async {
  _isLoading = true;
  notifyListeners();
  try {
    await _bookingRepo.completeBooking(booking.id);  
    await _userRepo.updateCurrentBooking(booking.userId, null);
    await loadRides(booking.userId);
  } catch (e) {
    debugPrint("Complete Error: $e");
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  Future<void> cancelBooking(Booking booking) async {
    _isLoading = true;
    notifyListeners();

    try {
      bool isElectric = booking.bikeId.startsWith("E");
      await _bookingRepo.cancelBooking(booking.id);

      await _userRepo.updateRideCounts(
        booking.userId,
        standardChange: isElectric ? 0 : 1,
        electricChange: isElectric ? 1 : 0,
      );
      await _userRepo.updateCurrentBooking(booking.userId, null);

      await loadRides(booking.userId);
    } catch (e) {
      debugPrint("Cancel Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void browseStations(BuildContext context) {
    Navigator.pushNamed(context, '/map');
  }
}
