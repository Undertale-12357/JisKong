import 'package:jis_kong/model/user/user.dart';

class UserDTO {
  static const String nameKey = 'name';
  static const String passIdKey = 'activePassId';
  static const String bookingIdKey = 'currentBookingId';
  static const String standardRidesKey = 'remainingStandardRides';
  static const String electricRidesKey = 'remainingElectricRides';

  static User fromJson(String id, Map<dynamic, dynamic> data) {
    return User(
      id: id,
      name: data[nameKey] ?? "Unknown User",
      activePassId: data[passIdKey] as String?,
      currentBookingId: data[bookingIdKey] as String?,
      remainingStandardRides:
          int.tryParse(data[standardRidesKey]?.toString() ?? '0') ?? 0,
      remainingElectricRides:
          int.tryParse(data[electricRidesKey]?.toString() ?? '0') ?? 0,
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      nameKey: user.name,
      passIdKey: user.activePassId,
      bookingIdKey: user.currentBookingId,
      standardRidesKey: user.remainingStandardRides,
      electricRidesKey: user.remainingElectricRides,
    };
  }
}
