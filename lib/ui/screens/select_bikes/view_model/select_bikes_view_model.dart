import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/booking/booking_repository_firebase.dart';
import 'package:jis_kong/model/booking/booking.dart';
import '../../../../model/station/station.dart';
import '../../../../model/bike/bike.dart';

class BikeSelectionViewModel extends ChangeNotifier {
  final Station station;
  final BookingRepositoryFirebase _bookingRepo;
  Bike? _selectedBike;
  bool _isLoading = false;

  BikeSelectionViewModel({
    required this.station,
    required BookingRepositoryFirebase bookingRepo,
  }) : _bookingRepo = bookingRepo;

  Bike? get selectedBike => _selectedBike;
  bool get isLoading => _isLoading;

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

  Future<bool> confirmBooking(String userId) async {
    if (_selectedBike == null) return false;
    _setLoading(true);

    try {
      final slotId = station.slots
          .firstWhere((s) => s.bike?.id == _selectedBike!.id)
          .id;

      final newBooking = Booking(
        id: "BK_${DateTime.now().millisecondsSinceEpoch}",
        userId: userId,
        stationId: station.id,
        bikeId: _selectedBike!.id,
        slotId: slotId,
        bookingTime: DateTime.now(),
        status: Status.Booking,
      );

      await _bookingRepo.createBooking(newBooking);
      return true; 
    } catch (e) {
      debugPrint("Booking Error: $e");
      return false; 
    } finally {
      _setLoading(false);
    }
  }
}
