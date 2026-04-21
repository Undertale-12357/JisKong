import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/booking/booking_repository_firebase.dart';
import '../../../../model/booking/booking.dart';

class MyRideViewModel extends ChangeNotifier {
  final BookingRepositoryFirebase _bookingRepo;

  List<Booking> _userBookings = [];
  bool _isLoading = false;
  Timer? _timer;
  Duration _rideDuration = Duration.zero;

  final String activeBookingStatus = "No Active Bookings";
  final String bookingSubtitle = "Find a station and book your next ride!";

  MyRideViewModel(this._bookingRepo);

  List<Booking> get userBookings => _userBookings;
  bool get isLoading => _isLoading;
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

  Future<void> endCurrentRide(Booking booking) async {
    _timer?.cancel();
    _rideDuration = Duration.zero;

    try {
      final updatedBooking = Booking(
        id: booking.id,
        userId: booking.userId,
        stationId: booking.stationId,
        bikeId: booking.bikeId,
        slotId: booking.slotId,
        bookingTime: booking.bookingTime,
        status: Status.Completed,
      );

      await _bookingRepo.updateBooking(updatedBooking);

      await loadRides(booking.userId);
    } catch (e) {
      debugPrint("Error ending ride: $e");
    }
  }

  void browseStations(BuildContext context) {
    Navigator.pushNamed(context, '/map');
  }
}
