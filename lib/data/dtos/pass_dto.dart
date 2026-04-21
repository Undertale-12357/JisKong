// import 'package:jis_kong/model/pass/pass.dart';

import '../../model/pass/pass.dart';

class PassDTO {
  static const String typeKey = 'type';
  static const String expiryKey = 'expirationDate';
  static const String activeKey = 'isActive';

  static Pass fromJson(String id, Map<String, dynamic> json) {
    return Pass(
      id: id,
      type: PassType.values.firstWhere((e) => e.name == json[typeKey]),
      expirationDate: DateTime.parse(json[expiryKey]),
      isActive: json[activeKey] ?? false,
    );
  }

  static Map<String, dynamic> toJson(PassType type) {
    final now = DateTime.now();
    DateTime expiry;

    if (type == PassType.day)
      expiry = now.add(const Duration(days: 1));
    else if (type == PassType.monthly)
      expiry = now.add(const Duration(days: 30));
    else
      expiry = now.add(const Duration(days: 365));

    return {
      typeKey: type.name,
      expiryKey: expiry.toIso8601String(),
      activeKey: true,
    };
  }
}
