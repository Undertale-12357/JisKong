import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/pass/pass_repository_firebase.dart';
import 'package:jis_kong/ui/screens/my_ride/view_model/my_ride_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../model/station/station.dart';
import 'view_model/select_bikes_view_model.dart';
import 'widget/bike_card.dart';
import 'package:jis_kong/data/repositories/booking/booking_repository_firebase.dart';
import 'package:jis_kong/data/repositories/user/user_repository_firebase.dart';

class BikeSelectionScreen extends StatelessWidget {
  final Station station;
  final VoidCallback onBookingSuccess;

  const BikeSelectionScreen({super.key, required this.station, required this.onBookingSuccess});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BikeSelectionViewModel(
        station: station,
        bookingRepo: context.read<BookingRepositoryFirebase>(),
        userRepo: context.read<UserRepositoryFirebase>(),
        passRepo: context.read<PassRepositoryFirebase>(),
      ),
      child: Consumer<BikeSelectionViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: const Color(0xFFFDFDFD),
            body: Column(
              children: [
                // Orange Gradient Header
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    top: 60,
                    left: 24,
                    right: 24,
                    bottom: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        station.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white70,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              station.name,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Available Bikes",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: vm.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 8, bottom: 24),
                          itemCount: vm.availableBikes.length,
                          itemBuilder: (context, index) {
                            final bike = vm.availableBikes[index];
                            final bool isElectric = bike.bikeType.name
                                .toLowerCase()
                                .contains("electric");
                            return BikeCard(
                              bike: bike,
                              hasActivePass: vm.hasActivePass,
                              remainingRide: isElectric
                                  ? vm.remainingElectric
                                  : vm.remainingStandard,
                              onBook: () async {
                                final String userId = "user_001";
                                final success = await vm.confirmBooking(
                                  userId,
                                  bike,
                                );

                                if (success && context.mounted) {
                                  await context
                                      .read<MyRideViewModel>()
                                      .loadRides(userId);
                                  if (!context.mounted) return;
                                  Navigator.pop(
                                    context, true
                                  ); 
                                  onBookingSuccess(); 
                                } else if (!success && context.mounted) {
                                  if (vm.errorMessage ==
                                      "You already have an active booking.") {
                                    await context
                                        .read<MyRideViewModel>()
                                        .loadRides(userId);
                                    if (!context.mounted) return;
                                    Navigator.pop(context, true);
                                    onBookingSuccess();
                                    return;
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        vm.errorMessage ?? "Booking failed",
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // void _showSuccessDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const Icon(
  //             Icons.check_circle_rounded,
  //             color: Colors.green,
  //             size: 80,
  //           ),
  //           const SizedBox(height: 16),
  //           const Text(
  //             "Enjoy your ride!",
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
  //           ),
  //           const SizedBox(height: 8),
  //           const Text(
  //             "Your bike has been unlocked successfully.",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(color: Colors.grey),
  //           ),
  //           const SizedBox(height: 24),
  //           SizedBox(
  //             width: double.infinity,
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 Navigator.popUntil(context, (route) => route.isFirst);
  //                 Navigator.pushNamed(context, '/my_rides');
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.orange,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 padding: const EdgeInsets.symmetric(vertical: 14),
  //               ),
  //               child: const Text(
  //                 "Back to Map",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         SizedBox(
  //           width: double.infinity,
  //           child: ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).popUntil((route) => route.isFirst);
  //               Navigator.of(context).pushNamed('/my_rides');
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.orange,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(12),
  //               ),
  //             ),
  //             child: const Text(
  //               "Go to My Rides",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
