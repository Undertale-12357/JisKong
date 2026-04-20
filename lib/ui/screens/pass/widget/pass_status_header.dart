import 'package:flutter/material.dart';
import 'package:jis_kong/model/pass/pass.dart';
import 'package:jis_kong/model/user/user.dart';

class PassStatusHeader extends StatelessWidget {
  final User? user;
  final Pass? activePass;
  const PassStatusHeader({super.key, this.user, this.activePass});

  @override
  Widget build(BuildContext context) {
    bool hasPass = user?.activePassId != null;

    String passTitle = "No Active Pass";
    if (hasPass && activePass != null) {
      passTitle =
          "${activePass!.type.name[0].toUpperCase()}${activePass!.type.name.substring(1)} Pass";
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasPass
              ? [const Color(0xFF22C55E), const Color(0xFF16A34A)]
              : [Colors.grey, Colors.grey.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 48),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "ACTIVE",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            passTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Renews on May 1, 2026",
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem("∞", "Rides"),
              _buildInfoItem("45", "Min Each"),
              _buildInfoItem("30", "Days Left"),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
            ),
            onPressed: () {},
            child: const Text("Manage Subscription"),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String val, String label) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
