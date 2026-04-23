import 'package:flutter/material.dart';
import 'package:jis_kong/ui/screens/my_ride/widget/active_ride_card.dart';
import 'package:provider/provider.dart';
import 'view_model/my_ride_view_model.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({super.key});

  @override
  State<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyRideViewModel>().loadRides("user_001");
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MyRideViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          _buildCustomAppBar(),
          Expanded(
            child: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : vm.activeBookings.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: vm.activeBookings.length,
                    itemBuilder: (context, index) {
                      final booking = vm.activeBookings[index];
                      return ActiveRideCard(
                        booking: booking,
                        onCancel: () => vm.cancelBooking(booking), 
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "My Rides",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_bike, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text(
            "No active bookings",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/map'), 
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Browse Stations",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
