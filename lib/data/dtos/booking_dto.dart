import 'package:jis_kong/model/booking/booking.dart';

class BookingDTO {
  static const String idKey = 'id';
  static const String userKey = 'userId';
  static const String stationKey = 'stationId';
  static const String bikeKey = 'bikeId';
  static const String slotKey = 'slotId';
  static const String timeKey = 'bookingTime';
  static const String statusKey = 'status';
  static const String unlockCodeKey = 'unlockCode';

  static Booking fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[userKey] is String);
    assert(json[stationKey] is String);
    assert(json[bikeKey] is String);
    assert(json[slotKey] is String);

    final rawTime = json[timeKey];
    final bookingTime = rawTime is String
        ? DateTime.parse(rawTime)
        : rawTime is int
            ? DateTime.fromMillisecondsSinceEpoch(rawTime)
            : rawTime is DateTime
                ? rawTime
                : DateTime.now();

    final rawStatus = json[statusKey]?.toString() ?? Status.Booking.name;
    final normalizedStatus =
        rawStatus[0].toUpperCase() + rawStatus.substring(1).toLowerCase();

    return Booking(
      id: json[idKey],
      userId: json[userKey],
      stationId: json[stationKey],
      bikeId: json[bikeKey],
      slotId: json[slotKey],
      bookingTime: bookingTime,
      status: Status.values.firstWhere(
        (e) => e.name == normalizedStatus,
        orElse: () => Status.Booking,
      ),
      unlockCode: json[unlockCodeKey] is int
          ? json[unlockCodeKey] as int
          : int.tryParse(json[unlockCodeKey]?.toString() ?? ''),
    );
  }

  static Map<String, dynamic> toJson(Booking booking) {
    return {
      idKey: booking.id,
      userKey: booking.userId,
      stationKey: booking.stationId,
      bikeKey: booking.bikeId,
      slotKey: booking.slotId,
      timeKey: booking.bookingTime.toIso8601String(),
      statusKey: booking.status.name,
      unlockCodeKey: booking.unlockCode,
    };
  }
}
