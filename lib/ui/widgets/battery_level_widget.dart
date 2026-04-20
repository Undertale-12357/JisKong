import 'package:flutter/material.dart';
import 'package:jis_kong/ui/theme/theme.dart';

class BatteryLevelWidget extends StatelessWidget {
  final int level; // 0 to 100

  const BatteryLevelWidget({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          level > 20 ? Icons.battery_full : Icons.battery_alert,
          color: JisKongTheme.batteryBlue, 
        ),
        Text(
          "$level%",
          style: const TextStyle(
            color: JisKongTheme.batteryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
