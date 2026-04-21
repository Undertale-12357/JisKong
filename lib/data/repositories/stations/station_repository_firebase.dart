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

  // lib/data/repositories/stations/station_repository_firebase.dart

  @override
  Future<List<Station>> getStations() async {
    final response = await http.get(Uri.parse('$_baseUrl/stations.json'));

    if (response.statusCode == 200) {
      final dynamic decodedData = json.decode(response.body);
      if (decodedData == null) return [];

      if (decodedData is List) {
        return decodedData
            .where(
              (item) => item != null,
            )
            .map((item) {
              final stationData = Map<String, dynamic>.from(item);
              return StationDto.fromJson(stationData);
            })
            .toList();
      }

      if (decodedData is Map) {
        final Map<String, dynamic> dataMap = Map<String, dynamic>.from(
          decodedData,
        );
        return dataMap.entries.map((entry) {
          final stationData = Map<String, dynamic>.from(entry.value);
          stationData['id'] = entry.key;
          return StationDto.fromJson(stationData);
        }).toList();
      }

      return [];
    } else {
      throw Exception("Failed to load stations: ${response.statusCode}");
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
