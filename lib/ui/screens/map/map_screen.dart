import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jis_kong/ui/screens/map/view_model/map_view_model.dart';
import 'package:jis_kong/ui/screens/map/widget/map_content.dart';

class MapScreen extends StatefulWidget {
  final VoidCallback onSwitchToRides;
  const MapScreen({super.key, required this.onSwitchToRides});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapViewModel>().fetchStations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MapContent(onSwitchToRides: widget.onSwitchToRides);
  }
}
