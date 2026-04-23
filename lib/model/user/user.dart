class User {
  final String id;
  final String name;
  final String? activePassId;
  final String? currentBookingId;
  final int remainingStandardRides;
  final int remainingElectricRides;

  User({
    required this.id,
    required this.name,
    this.activePassId,
    this.currentBookingId,
    this.remainingElectricRides = 0,
    this.remainingStandardRides = 0,
  });

  @override
  String toString() {
    return 'User(id: $id, name: $name, pass: $activePassId, booking: $currentBookingId, remainingStandardRides: $remainingStandardRides, remainingElectricRides: $remainingElectricRides)';
  }
}
