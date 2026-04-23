import 'package:flutter/material.dart';
import 'package:jis_kong/ui/widgets/appbar.dart';
import 'package:jis_kong/ui/screens/map/map_screen.dart';
import 'package:jis_kong/ui/screens/my_ride/my_ride_screen.dart'; // Import your ride screen
import 'package:jis_kong/ui/screens/my_ride/view_model/my_ride_view_model.dart';
import 'package:jis_kong/ui/screens/pass/pass_screen.dart';
import 'package:jis_kong/ui/widgets/navbart.dart'; // Import your pass/subscription screen
import 'package:provider/provider.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex;
  int _myRidesKey = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // context.read<MyRideViewModel>().loadRides("user_001");
      _myRidesKey++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      MapScreen(onSwitchToRides: () => _onItemTapped(1)),
      MyRidesScreen(
        key: ValueKey(_myRidesKey),
        onBrowseStations: () => _onItemTapped(0),
      ),
      const PassScreen(),
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: _selectedIndex == 0
            ? "Find a Bike"
            : _selectedIndex == 1
            ? "My Rides"
            : "Subscription",
      ),
      body: IndexedStack(index: _selectedIndex, children: screens),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
