import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class Ticket {
  String? id;
  Showtime showtime;

  Ticket({
    required this.id,
    required this.showtime,
  });

  Ticket.empty() : showtime = Showtime.empty();

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['_id'],
      showtime: Showtime.fromJson(json['showtime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'showtime': showtime.toJson(),
    };
  }
}
