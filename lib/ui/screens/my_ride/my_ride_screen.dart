import 'package:flutter/material.dart';
import 'view_model/my_ride_view_model.dart';
import 'widget/my_ride_content.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({super.key});

  @override
  State<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen> {
  final MyRideViewModel _viewModel = MyRideViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EB),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pedal_bike_outlined),
            label: 'My Rides',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            label: 'Subscription',
          ),
        ],
      ),
      body: SafeArea(child: MyRideContent(viewModel: _viewModel)),
    );
  }
}
