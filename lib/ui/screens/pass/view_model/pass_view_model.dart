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
      _currentUser = await _userRepo.getUserById(uid);
      if (_currentUser?.activePassId != null) {
        _activePassDetails = await _passRepo.getPassById(
          _currentUser!.activePassId!,
        );
      }
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

      await init(uid);

      notifyListeners();
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
  }
}
