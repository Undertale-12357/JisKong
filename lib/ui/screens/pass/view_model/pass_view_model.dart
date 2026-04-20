import 'package:flutter/material.dart';
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