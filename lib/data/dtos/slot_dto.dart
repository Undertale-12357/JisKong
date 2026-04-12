import 'package:jis_kong/data/dtos/bike_dto.dart';
import 'package:jis_kong/model/bike/slot.dart';

class SlotDTO {
  static const String idKey = 'id';
  static const String numberKey = 'slotNumber';
  static const String stationIdKey = 'stationId';
  static const String bikeKey = 'bike';

  static Slot fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[numberKey] is int);
    assert(json[stationIdKey] is String);

    return Slot(
      id: json[idKey],
      slotNumber: json[numberKey],
      stationId: json[stationIdKey],
      bike: json[bikeKey] != null ? BikeDTO.fromJson(json[bikeKey]) : null,
    );
  }

  static Map<String, dynamic> toJson(Slot slot) {
    return {
      idKey: slot.id,
      numberKey: slot.slotNumber,
      stationIdKey: slot.stationId,
      bikeKey: slot.bike != null ? BikeDTO.toJson(slot.bike!) : null,
    };
  }
}
