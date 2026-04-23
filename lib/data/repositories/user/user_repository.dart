import 'package:jis_kong/model/user/user.dart';

abstract class UserRepo {
  Future<User> getUserById(String uid);

  Stream<User> watchUser(String uid);

  Future<void> updateActivePass(String uid, String? passId);

  Future<void> updateCurrentBooking(String uid, String? bookingId);

  Future<void> updateRideCounts(String userId, {required int standardChange, required int electricChange});
}
