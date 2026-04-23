import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jis_kong/data/repositories/stations/station_repository_firebase.dart';
import 'package:jis_kong/ui/screens/select_bikes/select_bikes_screen.dart';
import '../../../../model/station/station.dart';
import 'package:geolocator/geolocator.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepositoryFirebase _stationRepo;

  List<Station> _stations = [];
  bool _isLoading = false;

  Map<String, BitmapDescriptor> _markerIcons = {};
  GoogleMapController? mapController;

  MapViewModel(this._stationRepo);

  List<Station> get stations => _stations;
  bool get isLoading => _isLoading;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void zoomIn() {
    mapController?.animateCamera(CameraUpdate.zoomIn());
  }

  void zoomOut() {
    mapController?.animateCamera(CameraUpdate.zoomOut());
  }

  void moveToLocation(LatLng position) {
    mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 15));
  }

  Future<void> moveCameraToUser() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();

    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        15,
      ),
    );
  }

  Future<void> _prepareIcons() async {
    for (var station in _stations) {
      final icon = await _getMarkerBitmap(station.availableBikesCount);
      _markerIcons[station.id] = icon;
    }
    notifyListeners();
  }

  Future<void> fetchStations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _stations = await _stationRepo.getStations();
      await _prepareIcons();
    } catch (e) {
      debugPrint("Firebase Map Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Set<Marker> markers(BuildContext context, VoidCallback onSwitchToRides) {
    return _stations.map((station) {
      return Marker(
        markerId: MarkerId(station.id),
        position: LatLng(station.latitude, station.longitude),
        icon: _markerIcons[station.id] ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: station.name,
          snippet: "${station.availableBikesCount} bikes available",
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BikeSelectionScreen(station: station, onBookingSuccess: onSwitchToRides,
            ),
            ),
          );
        },
      );
    }).toSet();
  }

  Future<BitmapDescriptor> _getMarkerBitmap(int bikeCount) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = ui.Canvas(pictureRecorder);
    const double size = 50.0;
    const double center = size / 2;
    const double radius = 15;

    final shadowPaint = ui.Paint()
      ..color = Colors.black.withOpacity(0.25)
      ..maskFilter = const ui.MaskFilter.blur(ui.BlurStyle.normal, 8);
    canvas.drawCircle(const Offset(center, center), radius, shadowPaint);

    final paint = ui.Paint()
      ..color = bikeCount > 2 ? Colors.orange : Colors.red;
    canvas.drawCircle(const Offset(center, center), radius, paint);

    final borderPaint = ui.Paint()
      ..color = Colors.white
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(const Offset(center, center), radius, borderPaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: '$bikeCount',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center - textPainter.width / 2, center - textPainter.height / 2),
    );

    final badgePaint = ui.Paint()..color = Colors.white;
    canvas.drawCircle(const Offset(center + 13, center - 10), 9, badgePaint);

    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(Icons.directions_bike.codePoint),
        style: TextStyle(
          fontSize: 11,
          fontFamily: Icons.directions_bike.fontFamily,
          color: bikeCount > 2 ? Colors.orange : Colors.red,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    iconPainter.layout();
    iconPainter.paint(canvas, const Offset(center + 8, center - 15));

    final img = await pictureRecorder.endRecording().toImage(
      size.toInt(),
      size.toInt(),
    );
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
