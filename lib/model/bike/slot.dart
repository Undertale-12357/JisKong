// import 'package:jis_kong/model/bike/bike.dart';

import 'bike.dart';

class Slot {
  final String id;
  final String stationId;
  final int slotNumber;
  final Bike? bike;

  Slot({
    required this.id,
    required this.stationId,
    required this.slotNumber,
    this.bike
  });

  bool get isAvailable => bike != null;

  @override
  String toString() {
    // TODO: implement toString
    return "Slot(id: $id, stationId: $stationId, slotNumber: $slotNumber, isAvailable: $isAvailable)";
  }
}
