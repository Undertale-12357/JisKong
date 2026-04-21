import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jis_kong/ui/screens/map/view_model/map_view_model.dart';
import 'package:jis_kong/ui/screens/select_bikes/select_bikes_screen.dart';
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
        onTap: (LatLng position) {},
        markers: vm.markers.map((marker) {
          return marker.copyWith(
            onTapParam: () {
              final station = vm.stations.firstWhere(
                (s) => s.id == marker.markerId.value,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BikeSelectionScreen(station: station),
                ),
              );
            },
          );
        }).toSet(),
      ),
    );
  }
}
