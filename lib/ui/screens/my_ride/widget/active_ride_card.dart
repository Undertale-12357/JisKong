import 'package:flutter/material.dart';
import 'package:jis_kong/model/booking/booking.dart';

class ActiveRideCard extends StatelessWidget {
  final Booking booking;
  final VoidCallback onCancel;

  const ActiveRideCard({super.key, required this.booking, required this.onCancel});

  String get _unlockCode => booking.unlockCode?.toString() ?? "----";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.orange, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Pickup Station", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(booking.stationId, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text("UNLOCK CODE", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                Text(_unlockCode, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange)),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider()),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onCancel, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    foregroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Cancel Ride"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}