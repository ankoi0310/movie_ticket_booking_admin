import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class Showtime {
  String? id;
  Movie movie;
  Room room;
  DateTime time;
  int bookedSeats;
  DateTime createdAt;
  DateTime updatedAt;

  Showtime({
    this.id,
    required this.movie,
    required this.room,
    required this.time,
    required this.bookedSeats,
    required this.createdAt,
    required this.updatedAt,
  });

  Showtime.empty()
      : movie = Movie.empty(),
        room = Room.empty(),
        time = DateTime.now(),
        bookedSeats = 0,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  factory Showtime.fromJson(Map<String, dynamic> json) {
    return Showtime(
      id: json['_id'],
      movie: Movie.fromJson(json['movie']),
      room: Room.fromJson(json['room']),
      time: DateTime.parse(json['time']),
      bookedSeats: json['booked_seats'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'movie': movie.toJson(),
      'room': room.toJson(),
      'time': time.toString(),
      'booked_seats': bookedSeats.toString(),
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
