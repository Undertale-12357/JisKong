import 'package:flutter/material.dart';
import 'package:jis_kong/model/booking/booking.dart';
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
                : vm.activeBooking == null && vm.recentBookings.isEmpty
                ? _buildEmptyState()
                : ListView(
                    padding: const EdgeInsets.only(bottom: 24),
                    children: [
                      if (vm.activeBooking != null) ...[
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
                          child: Text(
                            "Active Ride",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ActiveRideCard(
                          booking: vm.activeBooking!,
                          onCancel: () => vm.cancelBooking(vm.activeBooking!),
                        ),
                      ],
                      if (vm.recentBookings.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
                          child: Text(
                            "Recent Rides",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...vm.recentBookings.map(_buildRecentRideCard),
                      ],
                    ],
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

  Widget _buildRecentRideCard(Booking booking) {
    final statusText = booking.status.name;
    final statusColor = booking.status == Status.Completed
        ? Colors.green
        : Colors.redAccent;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
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
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.history_rounded, color: statusColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.stationId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Bike: ${booking.bikeId}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  "Status: $statusText",
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  booking.bookingTime.toString(),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
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
            onPressed: () => Navigator.pushNamed(context, '/map'),
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
