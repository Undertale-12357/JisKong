import 'dart:async';
import 'package:flutter/material.dart';

class PassViewModel extends ChangeNotifier {
  int _remainingSeconds = 892;
  Timer? _timer;

  final String bikeId = "BK-001";
  final String stationName = "Central Park Station";
  final String unlockCode = "6803";

  int get remainingSeconds => _remainingSeconds;

  PassViewModel() {
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  String get formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')} left";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
