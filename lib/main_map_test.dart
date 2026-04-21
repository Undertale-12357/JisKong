import 'package:flutter/material.dart';
import 'package:jis_kong/ui/screens/map/view_model/map_view_model.dart';
import 'package:jis_kong/ui/screens/map/widget/map_content.dart';
import 'package:provider/provider.dart';

// import 'map/map_view_model.dart';
// import 'map/map_content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapViewModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MapContent(),
      ),
    );
  }
}