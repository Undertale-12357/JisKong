import 'package:flutter/material.dart';
import 'package:jis_kong/model/booking/booking.dart';
import '../view_model/my_ride_view_model.dart';

class MyRideContent extends StatelessWidget {
  final MyRideViewModel viewModel;

  const MyRideContent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
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
            _buildActiveBookingCard(context),
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
            viewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.userBookings.length,
                    itemBuilder: (context, index) {
                      return _buildRideCard(viewModel.userBookings[index]);
                    },
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveBookingCard(BuildContext context) {
    final activeRide = viewModel.activeBooking;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: activeRide != null ? Colors.deepOrange : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 12, offset: Offset(0, 5)),
        ],
      ),
      child: activeRide == null
          ? _buildEmptyState(context)
          : _buildOngoingRideState(context, activeRide),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Column(
      children: [
        const Text(
          "No Active Bookings",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          "Find a station and book your next ride!",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/map');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Browse Stations"),
        ),
      ],
    );
  }

  Widget _buildOngoingRideState(BuildContext context ,Booking booking) {
    viewModel.startTimer(booking.bookingTime);

    return Column(
      children: [
        const Text("Ongoing Ride", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        Text(
          viewModel.formattedDuration,
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            bool? confirm = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("End Ride?"),
                content: const Text(
                  "Are you sure you want to return the bike?",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("End"),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              await viewModel.endCurrentRide(booking);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.deepOrange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
          ),
          child: const Text("End Ride"),
        ),
      ],
    );
  }

  Widget _buildRideCard(Booking booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFF2F4F7),
            child: Icon(Icons.pedal_bike_outlined, color: Colors.blueGrey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ride ID: ${booking.id.substring(0, 5)}", // Show short ID
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Status: ${booking.status}",
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            "${booking.bookingTime.year}-${booking.bookingTime.month.toString().padLeft(2, '0')}-${booking.bookingTime.day.toString().padLeft(2, '0')} ${booking.bookingTime.hour}:${booking.bookingTime.minute.toString().padLeft(2, '0')}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
