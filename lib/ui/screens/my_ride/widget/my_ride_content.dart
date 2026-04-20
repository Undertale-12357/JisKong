import 'package:flutter/material.dart';
import '../view_model/my_ride_view_model.dart';

class MyRideContent extends StatelessWidget {
  final MyRideViewModel viewModel;

  const MyRideContent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "My Rides",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D2233),
              ),
            ),
          ),
          const SizedBox(height: 35),
          _buildActiveBookingCard(),
          const SizedBox(height: 45),
          const Text(
            "Recent Rides",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2233),
            ),
          ),
          const SizedBox(height: 15),
          _buildRecentRideItem(),
        ],
      ),
    );
  }

  Widget _buildActiveBookingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 12, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: const Color(0xFFF2F4F7),
            child: Icon(
              Icons.pedal_bike,
              size: 34,
              color: Colors.blueGrey.shade300,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            viewModel.activeBookingStatus,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            viewModel.bookingSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.blueGrey.shade300),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
            ),
            onPressed: viewModel.browseStations,
            child: const Text(
              "Browse Stations",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentRideItem() {
    final ride = viewModel.recentRides[0];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFF2F4F7),
            child: Icon(
              Icons.pedal_bike_outlined,
              color: Colors.blueGrey.shade400,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ride['type'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${ride['location']} • ${ride['date']}",
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                ride['price'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ride['duration'],
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
