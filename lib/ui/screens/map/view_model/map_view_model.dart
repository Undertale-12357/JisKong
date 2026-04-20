import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jis_kong/model/station/station.dart';
import 'package:jis_kong/model/bike/slot.dart';
import 'package:jis_kong/model/bike/bike.dart';

class MapViewModel extends ChangeNotifier {
  final List<Station> _stations = [
    Station(
      id: "1",
      name: "Station A",
      latitude: 11.5564,
      longitude: 104.9282,
      slots: [
        Slot(id: "s1", stationId: "1", slotNumber: 1, bike: Bike(id: "b1", bikeType: BikeType.standart, stationId: "1")),
        Slot(id: "s2", stationId: "1", slotNumber: 2, bike: Bike(id: "b2", bikeType: BikeType.electric, stationId: "1", batteryLevel: 80)),
        Slot(id: "s3", stationId: "1", slotNumber: 3, bike: null),
      ],
    ),
    Station(
      id: "2",
      name: "Station B",
      latitude: 11.5650,
      longitude: 104.9300,
      slots: [
        Slot(id: "s4", stationId: "2", slotNumber: 1, bike: null),
        Slot(id: "s5", stationId: "2", slotNumber: 2, bike: null),
      ],
    ),
  ];

  Set<Marker> get markers {
    return _stations.map((station) {
      final bikeCount = station.availableBikesCount;

      return Marker(
        markerId: MarkerId(station.id),
        position: LatLng(station.latitude, station.longitude),

        // ✅ Show bike count
        infoWindow: InfoWindow(
          title: station.name,
          snippet: "Available bikes: $bikeCount",
        ),

        // 🎨 Highlight
        icon: bikeCount > 0
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    }).toSet();
  }
}