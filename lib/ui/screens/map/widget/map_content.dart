import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jis_kong/ui/screens/map/view_model/map_view_model.dart';
import 'package:provider/provider.dart';

class MapContent extends StatelessWidget {
  final VoidCallback onSwitchToRides;
  const MapContent({super.key, required this.onSwitchToRides});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MapViewModel>(context);

    return Stack(
      children: [
        GestureDetector(
          child: GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(11.5564, 104.9282),
              zoom: 14,
            ),
            onMapCreated: (controller) => vm.onMapCreated(controller),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            markers: vm.markers(context, onSwitchToRides),
          ),
        ),

        Positioned(
          top: 50,
          right: 15,
          child: Column(
            children: [
              _mapActionButton(Icons.add, () => vm.zoomIn()),
              const SizedBox(height: 10),
              _mapActionButton(Icons.remove, () => vm.zoomOut()),
              const SizedBox(height: 10),
              _mapActionButton(Icons.near_me_outlined, () {
                vm.moveToLocation(const LatLng(11.5564, 104.9282));
              }, iconColor: Colors.blue),
            ],
          ),
        ),

        Positioned(
          bottom: 30,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              // Add camera movement logic here
            },
            child: const Icon(Icons.gps_fixed, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _mapActionButton(
    IconData icon,
    VoidCallback onTap, {
    Color iconColor = Colors.black,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor),
        onPressed: onTap,
      ),
    );
  }
}
