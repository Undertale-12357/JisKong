import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../model/booking/booking.dart';
import '../../dtos/booking_dto.dart';
import 'booking_repository.dart';

class BookingRepositoryFirebase implements BookingRepo {
  final String _baseUrl =
      "https://jiskong-default-rtdb.asia-southeast1.firebasedatabase.app/";

  @override
  Future<void> createBooking(Booking booking) async {
    // We use PATCH or PUT with the booking ID as the key
    final response = await http.put(
      Uri.parse('$_baseUrl/bookings/${booking.id}.json'),
      body: json.encode(BookingDTO.toJson(booking)),
    );

    if (response.statusCode != 200) {
      throw Exception("Could not create booking");
    }
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    // Update status to 'cancelled'
    final response = await http.patch(
      Uri.parse('$_baseUrl/bookings/$bookingId.json'),
      body: json.encode({'status': 'cancelled'}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to cancel booking");
    }
  }

  @override
  Future<List<Booking>> getUserBookings(String userId) async {
    final response = await http.get(Uri.parse('$_baseUrl/bookings.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) return [];

      return data.entries
          .map((entry) {
            final bData = Map<String, dynamic>.from(entry.value);
            bData['id'] = entry.key;
            return BookingDTO.fromJson(bData);
          })
          .where((booking) => booking.userId == userId) 
          .toList();
    } else {
      throw Exception("Failed to fetch bookings");
    }
  }
}
