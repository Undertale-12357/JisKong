// import 'package:jis_kong/model/bike/bike.dart';

import '../../model/bike/bike.dart';

class BikeDTO {
  static const String idKey = 'id';
  static const String typeKey = 'bikeType';
  static const String stationIdKey = 'stationId';
  static const String batteryKey = 'batteryLevel';

  static Bike fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[typeKey] is String);
    assert(json[stationIdKey] is String);

    return Bike(
      id: json[idKey],
      bikeType: BikeType.values.firstWhere(
        (e) => e.name == json[typeKey],
        orElse: () => BikeType.standart,
      ),
      stationId: json[stationIdKey],
      batteryLevel: json[batteryKey] as int?,
    );
  }

  static Map<String, dynamic> toJson(Bike bike) {
    return {
      idKey: bike.id,
      typeKey: bike.bikeType.name,
      stationIdKey: bike.stationId,
      batteryKey: bike.batteryLevel,
    };
  }
}
