import 'package:jis_kong/model/booking/booking.dart';

class BookingDTO {
  static const String idKey = 'id';
  static const String userKey = 'userId';
  static const String stationKey = 'stationId';
  static const String bikeKey = 'bikeId';
  static const String slotKey = 'slotId';
  static const String timeKey = 'bookingTime';
  static const String statusKey = 'status';

  static Booking fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[userKey] is String);
    assert(json[stationKey] is String);
    assert(json[bikeKey] is String);
    assert(json[slotKey] is String);

    return Booking(
      id: json[idKey],
      userId: json[userKey],
      stationId: json[stationKey],
      bikeId: json[bikeKey],
      slotId: json[slotKey],
      bookingTime: json[timeKey],
      status: Status.values.firstWhere((e) => e.name == json[statusKey], orElse: () => Status.Booking),
    );
  }

  static Map<String, dynamic> toJson(Booking booking) {
    return {
      idKey: booking.id,
      stationKey: booking.stationId,
      bikeKey: booking.bikeId,
      slotKey: booking.slotId,
      timeKey: booking.bookingTime,
      statusKey: booking.status.name,
    };
  }
}
