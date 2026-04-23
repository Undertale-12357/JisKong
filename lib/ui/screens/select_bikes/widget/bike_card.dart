import 'package:flutter/material.dart';
import '../../../../model/bike/bike.dart';

class BikeCard extends StatelessWidget {
  final Bike bike;
  final bool hasActivePass;
  final VoidCallback? onBook;
  final int remainingRide;

  const BikeCard({
    super.key,
    required this.bike,
    required this.hasActivePass,
    this.onBook,
    required this.remainingRide,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = hasActivePass;
    final Color primaryColor = isActive ? Colors.orange : Colors.grey;
    final Color cardBg = isActive ? Colors.white : const Color(0xFFF2F2F2);
    final bool canBook = hasActivePass && remainingRide > 0;

    final bool isElectric = bike.bikeType.name.toLowerCase().contains(
      'electric',
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? Colors.orange.withOpacity(0.2) : Colors.transparent,
        ),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isElectric
                  ? Icons.electric_bike_rounded
                  : Icons.directions_bike_rounded,
              color: primaryColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${bike.bikeType.name} Bike",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isActive ? Colors.black87 : Colors.grey,
                  ),
                ),
                // Only show battery level if it's an electric bike
                if (isElectric && bike.batteryLevel != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.battery_charging_full,
                        size: 14,
                        color: isActive ? Colors.green : Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${bike.batteryLevel}%",
                        style: TextStyle(
                          color: isActive ? Colors.black54 : Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          ElevatedButton(
            onPressed: canBook ? onBook : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Book",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
