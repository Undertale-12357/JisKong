import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/booking/booking_repository_firebase.dart';
import 'package:jis_kong/data/repositories/pass/pass_repository_firebase.dart';
import 'package:jis_kong/data/repositories/user/user_repository_firebase.dart';
import 'package:jis_kong/model/booking/booking.dart';
import '../../../../model/station/station.dart';
import '../../../../model/bike/bike.dart';

class BikeSelectionViewModel extends ChangeNotifier {
  final Station station;
  final BookingRepositoryFirebase _bookingRepo;
  final UserRepositoryFirebase _userRepo;
  final PassRepositoryFirebase _passRepo;
  Bike? _selectedBike;
  bool _isLoading = false;
  String? _errorMessage;

  bool _hasActivePass = false;
  bool _isCheckingPass = true;

  int _remainingStandard = 0;
  int _remainingElectric = 0;

  BikeSelectionViewModel({
    required this.station,
    required BookingRepositoryFirebase bookingRepo,
    required UserRepositoryFirebase userRepo,
    required PassRepositoryFirebase passRepo,
  }) : _bookingRepo = bookingRepo,
       _userRepo = userRepo,
       _passRepo = passRepo {
    _loadInitialData("user_001");
  }

  Future<void> _loadInitialData(String userId) async {
    try {
      final user = await _userRepo.getUserById(userId);
      _hasActivePass = user.activePassId != null;
      _remainingStandard = user.remainingStandardRides;
      _remainingElectric = user.remainingElectricRides;
      notifyListeners();
    } catch (e) {
      _hasActivePass = false;
    } finally {
      _isCheckingPass = false;
      notifyListeners();
    }
  }

  Bike? get selectedBike => _selectedBike;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasActivePass => _hasActivePass;
  bool get isCheckingPass => _isCheckingPass;
  int get remainingStandard => _remainingStandard;
  int get remainingElectric => _remainingElectric;

  List<Bike> get availableBikes {
    return station.slots
        .where((slot) => slot.bike != null)
        .map((slot) => slot.bike!)
        .toList();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void selectBike(Bike bike) {
    _selectedBike = bike;
    notifyListeners();
  }

  Future<bool> confirmBooking(String userId, Bike bike) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final user = await _userRepo.getUserById(userId);

      if (user.activePassId == null) {
        throw "You need an active pass to book a bike.";
      }
      final pass = await _passRepo.getPassById(user.activePassId!);
      final bool isElectric = bike.bikeType.name.toLowerCase().contains(
        'electric',
      );

      if (isElectric) {
        if (user.remainingElectricRides <= 0) {
          throw "No electric rides left. Please upgrade your pass.";
        }
      } else {
        if (user.remainingStandardRides <= 0) {
          throw "No standard rides left today.";
        }
      }

      await _userRepo.updateRideCounts(
        userId,
        standardChange: isElectric ? 0 : -1,
        electricChange: isElectric ? -1 : 0,
      );

      final slotId = station.slots.firstWhere((s) => s.bike?.id == bike.id).id;
      final newBooking = Booking(
        id: "BK_${DateTime.now().millisecondsSinceEpoch}",
        userId: userId,
        stationId: station.name,
        bikeId: bike.id,
        slotId: slotId,
        bookingTime: DateTime.now(),
        status: Status.Booking,
        unlockCode: (1000 + Random().nextInt(9000)),
      );

      await _bookingRepo.createBooking(newBooking);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _setLoading(false);
      notifyListeners();
      return false;
    } //finally {
    //   _setLoading(false);
    //   notifyListeners();
    // }
  }
}
