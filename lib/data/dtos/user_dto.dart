import 'package:jis_kong/model/user/user.dart';

class UserDTO {
  static const String nameKey = 'name';
  static const String passIdKey = 'activePassId';
  static const String bookingIdKey = 'currentBookingId';

static User fromJson(String id, Map<dynamic, dynamic> data) {
    return User(
      id: id,
      name: data[nameKey] ?? "Unknown User",
      activePassId: data[passIdKey] as String?,
      currentBookingId: data[bookingIdKey] as String?,
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      nameKey: user.name,
      passIdKey: user.activePassId,
      bookingIdKey: user.currentBookingId,
    };
  }
}
