enum PassType { day, monthly, annual }

class Pass {
  final String id;
  final PassType type;
  final DateTime expirationDate;
  final bool isActive;

  Pass({
    required this.id,
    required this.type,
    required this.expirationDate,
    this.isActive = true,
  });

  @override
  String toString() {
    // TODO: implement toString
    return "Pass(id: $id, type: $type, expirationDate: $expirationDate, isActive: $isActive)";
  }
}