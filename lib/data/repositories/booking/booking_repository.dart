import '../../../model/booking/booking.dart'; 

abstract class BookingRepo {
  Future<void> createBooking(Booking booking);
  Future<void> cancelBooking(String bookingId);
  Future<List<Booking>> getUserBookings(String userId);
}
