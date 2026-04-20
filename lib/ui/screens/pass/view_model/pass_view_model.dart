import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======
import 'package:jis_kong/model/pass/pass.dart';

class PassViewModel extends ChangeNotifier {
  Pass? _pass;

  Pass? get pass => _pass;

  void setPass(Pass pass) {
    _pass = pass;
    _updateExpirationStatus();
    notifyListeners();
  }

  void clearPass() {
    _pass = null;
    notifyListeners();
  }

  bool get hasPass => _pass != null;

  bool get isExpired {
    if (_pass == null) return true;
    return DateTime.now().isAfter(_pass!.expirationDate);
  }

  bool get hasActivePass {
    if (_pass == null) return false;
    return _pass!.isActive && !isExpired;
  }

  Duration get remainingTime {
    if (_pass == null) return Duration.zero;

    final diff = _pass!.expirationDate.difference(DateTime.now());
    return diff.isNegative ? Duration.zero : diff;
  }

  int get daysLeft => remainingTime.inDays;

  void createPass(PassType type) {
    final now = DateTime.now();

    Duration duration;

    switch (type) {
      case PassType.day:
        duration = const Duration(days: 1);
        break;
      case PassType.monthly:
        duration = const Duration(days: 30);
        break;
      case PassType.annual:
        duration = const Duration(days: 365);
        break;
    }

    final expiry = now.add(duration);

    _pass = Pass(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: type,
      expirationDate: expiry,
      isActive: true,
    );

    notifyListeners();
  }

  void _updateExpirationStatus() {
    if (_pass == null) return;

    if (DateTime.now().isAfter(_pass!.expirationDate)) {
      _pass = Pass(
        id: _pass!.id,
        type: _pass!.type,
        expirationDate: _pass!.expirationDate,
        isActive: false,
      );
    }
  }

  void checkAndExpirePass() {
    _updateExpirationStatus();
    notifyListeners();
  }
}
>>>>>>> rith
