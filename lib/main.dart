import 'package:flutter/material.dart';
import 'package:jis_kong/ui/screens/map/map_screen.dart';
import 'package:jis_kong/ui/screens/my_ride/my_ride_screen.dart';
import 'package:provider/provider.dart';
import 'package:jis_kong/data/repositories/stations/station_repository_firebase.dart';
import 'package:jis_kong/data/repositories/booking/booking_repository_firebase.dart';
import 'package:jis_kong/data/repositories/pass/pass_repository_firebase.dart';
import 'package:jis_kong/data/repositories/user/user_repository_firebase.dart'; // Added
import 'package:jis_kong/ui/screens/map/view_model/map_view_model.dart';
import 'package:jis_kong/ui/screens/my_ride/view_model/my_ride_view_model.dart';
import 'package:jis_kong/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:jis_kong/ui/screens/main_navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => StationRepositoryFirebase()),
        Provider(create: (_) => BookingRepositoryFirebase()),
        Provider(create: (_) => PassRepositoryFirebase()),
        Provider(
          create: (_) => UserRepositoryFirebase(),
        ), 

        ChangeNotifierProvider(
          create: (context) =>
              MapViewModel(context.read<StationRepositoryFirebase>()),
        ),
        ChangeNotifierProvider(
          create: (context) => MyRideViewModel(
            context.read<BookingRepositoryFirebase>(),
            context.read<UserRepositoryFirebase>(), 
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PassViewModel(
            context.read<UserRepositoryFirebase>(), 
            context.read<PassRepositoryFirebase>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Jis Kong',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const MainNavigationScreen(),
        initialRoute: '/',
        routes: {
          // '/': (context) => const HomeScreen(),
          '/map': (context) => const MapScreen(), 
          '/my_rides': (context) =>
              const MyRidesScreen(), 
        },
      ),
    );
  }
}
