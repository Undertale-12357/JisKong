import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/pass/pass_repository_firebase.dart';
import 'package:jis_kong/data/repositories/user/user_repository_firebase.dart';
import 'package:jis_kong/ui/screens/pass/pass_screen.dart';
import 'package:jis_kong/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  final userRepo = UserRepositoryFirebase();
  final passRepo = PassRepositoryFirebase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PassViewModel(userRepo, passRepo)..init("user_001"),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jis Kong',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: PassScreen(),
    );
  }
}
