import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jis_kong/data/dtos/pass_dto.dart';
import 'package:jis_kong/data/repositories/pass/pass_repository.dart';
import 'package:jis_kong/model/pass/pass.dart';

class PassRepositoryFirebase implements PassRepo {
  final String baseUrl =
      'https://jiskong-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<Pass> createPass(PassType type) async {
    final Uri url = Uri.parse('$baseUrl/passes.json');

    final response = await http.post(
      url,
      body: json.encode(PassDTO.toJson(type)),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String generatedId = data['name'];

      return Pass(
        id: generatedId,
        type: type,
        expirationDate: _calculateExpiry(type),
      );
    } else {
      throw Exception('Failed to create pass: ${response.statusCode}');
    }
  }

  @override
  Future<Pass> getPassById(String passId) async {
    final Uri url = Uri.parse('$baseUrl/passes/$passId.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      if (response.body == 'null') throw Exception('Pass not found');
      final Map<String, dynamic> data = json.decode(response.body);
      return PassDTO.fromJson(passId, data);
    } else {
      throw Exception('Failed to fetch pass');
    }
  }

  DateTime _calculateExpiry(PassType type) {
    if (type == PassType.day)
      return DateTime.now().add(const Duration(days: 1));
    if (type == PassType.monthly)
      return DateTime.now().add(const Duration(days: 30));
    return DateTime.now().add(const Duration(days: 365));
  }
}
