// import 'package:jis_kong/data/dtos/slot_dto.dart';
// import 'package:jis_kong/model/station/station.dart';

import '../../model/station/station.dart';
import 'slot_dto.dart';

class StationDto {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String latKey = 'latitude';
  static const String lngKey = 'longitude';
  static const String slotsKey = 'slots';

  static Station fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[nameKey] is String);
    assert(json[latKey] is num);
    assert(json[lngKey] is num);
    assert(json[slotsKey] is List);

    return Station(
      id: json[idKey],
      name: json[nameKey],
      latitude: (json[latKey] as num).toDouble(),
      longitude: (json[lngKey] as num).toDouble(),
      // Using the SlotDto.fromJson for the nested list [cite: 74]
      slots: (json[slotsKey] as List)
          .map((slotJson) => SlotDTO.fromJson(slotJson))
          .toList(),
    );
  }

  static Map<String, dynamic> toJson(Station station) {
    return {
      idKey: station.id,
      nameKey: station.name,
      latKey: station.latitude,
      lngKey: station.longitude,
      slotsKey: station.slots.map((slot) => SlotDTO.toJson(slot)).toList(),
    };
  }
}
