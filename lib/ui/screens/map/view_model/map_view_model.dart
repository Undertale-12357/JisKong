import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jis_kong/data/repositories/stations/station_repository_firebase.dart';
// import '../../../../data/repositories/stations/station_repository.dart';
import '../../../../model/station/station.dart';

class MapViewModel extends ChangeNotifier {
  final StationRepositoryFirebase _stationRepo;

  List<Station> _stations = [];
  bool _isLoading = false;

  MapViewModel(this._stationRepo);

  List<Station> get stations => _stations;
  bool get isLoading => _isLoading;

  Future<void> fetchStations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _stations = await _stationRepo.getStations();
    } catch (e) {
      debugPrint("Firebase Map Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Set<Marker> get markers {
    return _stations.map((station) {
      return Marker(
        markerId: MarkerId(station.id),
        position: LatLng(station.latitude, station.longitude),
        infoWindow: InfoWindow(
          title: station.name,
          snippet: "${station.availableBikesCount} bikes available",
        ),
      );
    }).toSet();
  }
}
