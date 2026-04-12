enum BikeType { standart, electric }

class Bike {
  final String id;
  final BikeType bikeType;
  final String stationId;
  int? batteryLevel;

  Bike({
    required this.id,
    required this.bikeType,
    required this.stationId,
    this.batteryLevel,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "Bike(id: $id, bikeType: $bikeType, stationId: $stationId, batteryLevel: $batteryLevel)";
  }
}
