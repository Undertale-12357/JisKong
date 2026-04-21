import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/stations/station_repository_firebase.dart';
import 'package:jis_kong/ui/screens/map/view_model/map_view_model.dart';
import 'package:jis_kong/ui/screens/my_ride/view_model/my_ride_view_model.dart';
import 'package:provider/provider.dart';
import 'data/repositories/booking/booking_repository_firebase.dart';
import 'ui/screens/map/map_screen.dart';
import 'ui/screens/my_ride/my_ride_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<StationRepositoryFirebase>(
          create: (_) => StationRepositoryFirebase(),
        ),
        Provider<BookingRepositoryFirebase>(
          create: (_) => BookingRepositoryFirebase(),
        ),

        ChangeNotifierProvider(
          create: (context) =>
              MapViewModel(context.read<StationRepositoryFirebase>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              MyRideViewModel(context.read<BookingRepositoryFirebase>()),
        ),
      ],
      child: MaterialApp(
        title: 'Jis Kong',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepOrange, useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/': (context) => const MapScreen(),
          '/my_rides': (context) => const MyRidesScreen(),
        },
      ),
    );
  }
}
