import 'package:jis_kong/model/user/user.dart';

class UserDto {
  static const String idKey = 'id';
  static const String nameKey = 'name';
  static const String passIdKey = 'activePassId';
  static const String bookingIdKey = 'currentBookingId';

  static User fromJson(Map<String, dynamic> json) {
    // Assertions help catch data errors early during development
    assert(json[idKey] is String);
    assert(json[nameKey] is String);

    return User(
      id: json[idKey],
      name: json[nameKey],
      activePassId: json[passIdKey] as String?,
      currentBookingId: json[bookingIdKey] as String?,
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      idKey: user.id,
      nameKey: user.name,
      passIdKey: user.activePassId,
      bookingIdKey: user.currentBookingId,
    };
  }
}
