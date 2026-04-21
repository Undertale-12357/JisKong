class User {
  final String id;
  final String name;
  final String? activePassId;
  final String? currentBookingId;

  User({
    required this.id,
    required this.name,
    this.activePassId,
    this.currentBookingId,
  });

  @override
  String toString() {
    return 'User(id: $id, name: $name, pass: $activePassId, booking: $currentBookingId)';
  }
}
