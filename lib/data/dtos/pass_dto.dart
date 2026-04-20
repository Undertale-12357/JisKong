// import 'package:jis_kong/model/pass/pass.dart';

import '../../model/pass/pass.dart';

class PassDto {
  static const String idKey = 'id';
  static const String typeKey = 'type';
  static const String expiryKey = 'expirationDate';
  static const String activeKey = 'isActive';

  static Pass fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[typeKey] is String);
    assert(json[expiryKey] is String);
    assert(json[activeKey] is bool);

    return Pass(
      id: json[idKey],
      type: PassType.values.firstWhere((e) => e.name == json[typeKey]),
      expirationDate: DateTime.parse(json[expiryKey]),
      isActive: json[activeKey],
    );
  }

  static Map<String, dynamic> toJson(Pass pass) {
    return {
      idKey: pass.id,
      typeKey: pass.type.name,
      expiryKey: pass.expirationDate.toIso8601String(),
      activeKey: pass.isActive,
    };
  }
}
