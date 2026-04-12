import 'package:jis_kong/model/bike/slot.dart';

class Station {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final List<Slot> slots;

  Station({
    required this.id,
    required this.name,
    required this.slots,
    required this.latitude,
    required this.longitude,
  });

  int get availableBikesCount => slots.where((slot) => slot.bike != null).length;

  @override
  String toString() {
    // TODO: implement toString
    return "Station(id :$id, name: $name, availableBikesCount: $availableBikesCount, location: $latitude, longitude: $longitude)";
  }
}
