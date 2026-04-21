import '../../../model/station/station.dart';
import '../../../model/bike/bike.dart';

abstract class StationRepo {
  Future<List<Station>> getStations();
  Future<Station> getStationDetails(String id);
  Future<void> updateSlot(String stationId, String slotId, {Bike? bike});
}
