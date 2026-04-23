import 'package:flutter/material.dart';
import 'package:jis_kong/ui/widgets/appbar.dart';
import 'package:jis_kong/ui/screens/map/map_screen.dart';
import 'package:jis_kong/ui/screens/my_ride/my_ride_screen.dart'; // Import your ride screen
import 'package:jis_kong/ui/screens/pass/pass_screen.dart';
import 'package:jis_kong/ui/widgets/navbart.dart'; // Import your pass/subscription screen

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MapScreen(), 
    const MyRidesScreen(), 
    const PassScreen(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _selectedIndex == 0
            ? "Find a Bike"
            : _selectedIndex == 1
            ? "My Rides"
            : "Subscription",
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
