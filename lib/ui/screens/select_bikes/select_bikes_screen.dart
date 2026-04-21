import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/booking/booking_repository_firebase.dart';
import 'package:jis_kong/ui/screens/select_bikes/view_model/select_bikes_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../model/station/station.dart';

class BikeSelectionScreen extends StatelessWidget {
  final Station station;

  const BikeSelectionScreen({super.key, required this.station});

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            const Text(
              "Booking Successful!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/my_rides',
                (route) => false,
              ),
              child: const Text("Go to My Rides"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BikeSelectionViewModel(
        station: station,
        bookingRepo: context.read<BookingRepositoryFirebase>(),
      ),
      child: Consumer<BikeSelectionViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(station.name),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Choose your ride",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.availableBikes.length,
                    itemBuilder: (context, index) {
                      final bike = vm.availableBikes[index];
                      final isSelected = vm.selectedBike?.id == bike.id;

                      return GestureDetector(
                        onTap: () => vm.selectBike(bike),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.deepOrange
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.pedal_bike,
                                size: 40,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bike.bikeType.name.toUpperCase(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Battery: ${bike.batteryLevel ?? 'N/A'}%",
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.deepOrange,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ElevatedButton(
                    onPressed: (vm.selectedBike == null || vm.isLoading)
                      ? null
                      : () async {
                    bool success = await vm.confirmBooking("user_001");

                    if (success && context.mounted) {
                      _showSuccessDialog(context);
                    }
                    },
                    child: vm.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Confirm Selection"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
