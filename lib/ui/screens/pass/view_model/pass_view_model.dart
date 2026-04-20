<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/pass/pass_repository_firebase.dart';
import 'package:jis_kong/data/repositories/user/user_repository_firebase.dart';
import 'package:jis_kong/model/pass/pass.dart';
import 'package:jis_kong/model/user/user.dart';


class PassViewModel extends ChangeNotifier {
  final UserRepositoryFirebase _userRepo;
  final PassRepositoryFirebase _passRepo;

  PassViewModel(this._userRepo, this._passRepo);

  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;

  Future<void> init(String uid) async {
    _setLoading(true);
    try {
      _currentUser = await _userRepo.getUserById(uid);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load profile: $e";
    } finally {
      _setLoading(false);
    }
  }

  Future<void> buyPass(String uid, PassType type) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      final Pass newPass = await _passRepo.createPass(type);

      await _userRepo.updateActivePass(uid, newPass.id);

      _currentUser = await _userRepo.getUserById(uid);

      print("Purchase successful for ${type.name}");
    } catch (e) {
      _errorMessage = "Purchase failed: $e";
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> processMockPayment(double amount) async {
    _setLoading(true);

    await Future.delayed(const Duration(seconds: 2));

    _setLoading(false);
    return true;
  }

  Future<void> handlePurchaseFlow(
    String uid,
    PassType type,
    double price,
  ) async {
    final success = await processMockPayment(price);

    if (success) {
      await buyPass(uid, type);
    } else {
      _errorMessage = "Payment Declined by Bank";
      notifyListeners();
    }
  }

  PassType? _pendingPassType;
  double _pendingPrice = 0.0;

  PassType? get pendingPassType => _pendingPassType;
  double get pendingPrice => _pendingPrice;

  void setPendingPurchase(PassType type, double price) {
    _pendingPassType = type;
    _pendingPrice = price;
    notifyListeners(); 
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
=======
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
>>>>>>> d56e23e35c6cb0aa15a4bdb81852732fea1b684c
  }
}
