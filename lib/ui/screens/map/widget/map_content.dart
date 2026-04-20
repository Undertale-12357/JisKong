import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jis_kong/ui/screens/map/view_model/map_view_model.dart';
import 'package:provider/provider.dart';
// import 'map_view_model.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MapViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Bike Stations")),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(11.5564, 104.9282),
          zoom: 14,
        ),
        markers: vm.markers,
      ),
    );
  }
}