import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/station/station.dart';
import '../../../model/bike/bike.dart';
import '../../dtos/station_dto.dart';
import '../../dtos/bike_dto.dart';
import 'station_repository.dart';

class StationRepositoryFirebase implements StationRepo {
  final String _baseUrl =
      "https://jiskong-default-rtdb.asia-southeast1.firebasedatabase.app/";

  @override
  Future<List<Station>> getStations() async {
    final response = await http.get(Uri.parse('$_baseUrl/stations.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) return [];

      return data.entries.map((entry) {
        final stationData = Map<String, dynamic>.from(entry.value);
        stationData['id'] = entry.key;
        return StationDto.fromJson(stationData);
      }).toList();
    } else {
      throw Exception("Failed to load stations");
    }
  }

  @override
  Future<Station> getStationDetails(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/stations/$id.json'));

    if (response.statusCode == 200 && response.body != 'null') {
      final data = json.decode(response.body);
      data['id'] = id;
      return StationDto.fromJson(data);
    } else {
      throw Exception("Station not found");
    }
  }

  @override
  Future<void> updateSlot(String stationId, String slotId, {Bike? bike}) async {
    final url = Uri.parse('$_baseUrl/stations/$stationId/slots/$slotId.json');

    final response = await http.patch(
      url,
      body: json.encode({'bike': bike != null ? BikeDTO.toJson(bike) : null}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update slot");
    }
  }
}
