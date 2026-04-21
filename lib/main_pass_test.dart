import 'package:flutter/material.dart';
import 'package:jis_kong/ui/screens/pass/pass_screen.dart';
import 'package:jis_kong/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PassViewModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PassScreen(),
      ),
    );
  }
}