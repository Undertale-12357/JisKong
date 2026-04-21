// lib/ui/widgets/custom_nav_bar.dart
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.orange, 
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed, 
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on_outlined), 
          activeIcon: Icon(Icons.location_on),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_bike_outlined), 
          activeIcon: Icon(Icons.directions_bike),
          label: 'My Rides',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_number_outlined), 
          label: 'Subscription',
        ),
      ],
    );
  }
}