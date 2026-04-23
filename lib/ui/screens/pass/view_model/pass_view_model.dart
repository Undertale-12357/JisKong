import 'package:flutter/material.dart';
import 'package:jis_kong/data/repositories/pass/pass_repository_firebase.dart';
import 'package:jis_kong/data/repositories/user/user_repository_firebase.dart';
import 'package:jis_kong/model/pass/pass.dart';
import 'package:jis_kong/model/user/user.dart';

class PassViewModel extends ChangeNotifier {
  final UserRepositoryFirebase _userRepo;
  final PassRepositoryFirebase _passRepo;

  PassViewModel(this._userRepo, this._passRepo);

  Pass? _activePassDetails;
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  Pass? get activePassDetails => _activePassDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;

  Future<void> init(String uid) async {
    _setLoading(true);
    try {
      final user = await _userRepo.getUserById(uid);
      _currentUser = user;
      if (user.activePassId != null &&
          user.activePassId!.isNotEmpty &&
          user.activePassId != "null") {
        _activePassDetails = await _passRepo.getPassById(user.activePassId!);
      } else {
        _activePassDetails = null;
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = "Failed to load profile: $e";
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> buyPass(String uid, PassType type) async {
    _setLoading(true);
    try {
      final Pass newPass = await _passRepo.createPass(type);
      await _userRepo.updateActivePass(uid, newPass.id);

      int std = 0;
      int ele = 0;

      final typeName = type.name.toLowerCase();

      if (typeName.contains('day')) {
        std = 4;
        ele = 0;
      } else if (typeName.contains('monthly')) {
        std = 30;
        ele = 10;
      } else if (typeName.contains('annual')) {
        std = 9999;
        ele = 9999;
      }

      await _userRepo.updateRideCounts(
        uid,
        standardChange: std,
        electricChange: ele,
        isReset: true,
      );

      if (_currentUser != null) {
        _currentUser = User(
          id: _currentUser!.id,
          name: _currentUser!.name,
          activePassId: newPass.id,
          currentBookingId: _currentUser!.currentBookingId,
          remainingStandardRides: std,
          remainingElectricRides: ele,
        );
      }

      _activePassDetails = newPass;
      notifyListeners();

      await init(uid);
    } catch (e) {
      _errorMessage = "Purchase failed: $e";
      notifyListeners();
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
  }
}
