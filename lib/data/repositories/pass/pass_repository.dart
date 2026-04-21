import 'package:jis_kong/model/pass/pass.dart';

abstract class PassRepo {
  Future<Pass> createPass(PassType type);
  Future<Pass> getPassById(String id);
}
