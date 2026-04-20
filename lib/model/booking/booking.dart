enum Status { Booking, Conpleted, Cancelled }

class Booking {
  final String id;
  final String userId;
  final String bikeId;
  final String stationId;
  final String slotId;
  final DateTime bookingTime;
  final Status status;
  int? unlockCode;

  Booking({
    required this.id,
    required this.userId,
    required this.bikeId,
    required this.stationId,
    required this.slotId,
    required this.bookingTime,
    required this.status,
    this.unlockCode,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "Booking(id: $id, userId: $userId, bikeId: $bikeId, stationId: $stationId, slotId: $slotId, bookingTime: $bookingTime, status: $status)";
  }
}
