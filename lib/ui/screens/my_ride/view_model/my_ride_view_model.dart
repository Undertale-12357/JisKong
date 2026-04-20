import 'package:flutter/material.dart';

class MyRideViewModel extends ChangeNotifier {
  final String activeBookingStatus = "No Active Bookings";
  final String bookingSubtitle = "Find a station and book your next ride!";

  final List<Map<String, dynamic>> recentRides = [
    {
      "type": "Standard Bike",
      "location": "Central Station",
      "date": "Apr 1, 2026",
      "price": "\$4.50",
      "duration": "15 min",
    },
  ];

  void browseStations() {
    debugPrint("Navigating to stations...");
  }
}
