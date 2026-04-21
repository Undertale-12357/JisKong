import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jis_kong/data/dtos/user_dto.dart';
import 'package:jis_kong/data/repositories/user/user_repository.dart';
import 'package:jis_kong/model/user/user.dart';


class UserRepositoryFirebase implements UserRepo {
  final String baseUrl =
      'https://jiskong-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<User> getUserById(String uid) async {
    final Uri url = Uri.parse('$baseUrl/users/$uid.json');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      if (response.body == 'null') {
        return User(id: uid, name: "New User");
      }

      final Map<String, dynamic> data = json.decode(response.body);
      return UserDTO.fromJson(uid, data);
    } else {
      throw Exception('Server Error: ${response.statusCode}');
    }
  }

  @override
  Future<void> updateActivePass(String uid, String? passId) async {
    final Uri url = Uri.parse('$baseUrl/users/$uid.json');

    final response = await http.patch(
      url,
      body: json.encode({UserDTO.passIdKey: passId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update pass');
    }
  }

  @override
  Future<void> updateCurrentBooking(String uid, String? bookingId) async {
    final Uri url = Uri.parse('$baseUrl/users/$uid.json');

    final response = await http.patch(
      url,
      body: json.encode({UserDTO.bookingIdKey: bookingId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update booking');
    }
  }

  @override
  Stream<User> watchUser(String uid) {
    throw UnimplementedError('Streaming not supported via pure REST HTTP');
  }
}
