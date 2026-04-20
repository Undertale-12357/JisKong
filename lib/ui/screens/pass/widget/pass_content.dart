import 'package:flutter/material.dart';
import '../view_model/pass_view_model.dart';

class PassContent extends StatelessWidget {
  final PassViewModel viewModel;

  const PassContent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Center(
            child: Text(
              "My Rides",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D2233),
              ),
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            "Active Booking",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2233),
            ),
          ),
          const SizedBox(height: 16),
          _buildActiveCard(),
          const SizedBox(height: 28),
          const Text(
            "Recent Rides",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2233),
            ),
          ),
          const SizedBox(height: 16),
          _buildRecentRideCard(),
        ],
      ),
    );
  }

  Widget _buildActiveCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFFD3A8)),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildBadge(
                "Reserved",
                const Color(0xFFDDF7EA),
                const Color(0xFF149954),
              ),
              const Spacer(),
              Text(
                viewModel.formattedTime,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildBikeInfo(),
          const Divider(height: 30),
          _buildLocationInfo(),
          const SizedBox(height: 18),
          _buildUnlockCode(),
          const SizedBox(height: 18),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildUnlockCode() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2CC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "UNLOCK CODE",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            viewModel.unlockCode,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
              letterSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: text, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildBikeInfo() {
    return Row(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.pedal_bike, color: Colors.white, size: 28),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Standard Bike",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D2233),
              ),
            ),
            Text(
              "ID: ${viewModel.bikeId}",
              style: const TextStyle(color: Color(0xFF64748B)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: Colors.deepOrange,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                viewModel.stationName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF1D2233),
                ),
              ),
              const Text(
                "123 Park Avenue, Downtown",
                style: TextStyle(color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {},
        icon: const Icon(Icons.lock_outline, color: Colors.white),
        label: const Text(
          "View Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildRecentRideCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.pedal_bike_outlined,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(child: Text("Standard Bike ride...")),
          const Text("\$4.50"),
        ],
      ),
    );
  }
}
