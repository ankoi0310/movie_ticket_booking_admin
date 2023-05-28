import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/invoice.dart';

class ShowTime extends General {
  Room? room;
  DateTime? startTime;
  DateTime? endTime;
  Movie? movie;
  int price;
  MovieFormat movieFormat;
  List<Invoice> invoices;

  ShowTime({
    required int id,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.movie,
    required this.movieFormat,
    required this.price,
    required this.invoices,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(
    id: id,
    state: state,
    createdDate: createdDate,
    modifiedDate: modifiedDate,
    deletedDate: deletedDate,
  );

  ShowTime.empty()
      : room = Room.empty(),
        startTime = DateTime.now(),
        endTime = DateTime.now(),
        movie = Movie.empty(),
        movieFormat = MovieFormat.twoD,
        price = 0,
        invoices = [],
        super.empty();

  factory ShowTime.fromJson(Map<String, dynamic> json) {
    return ShowTime(
      id: json['id'] as int,
      room: json['room'] == null ? null : Room.fromJson(json['room'] as Map<String, dynamic>),
      startTime: json['startTime'] != null ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['startTime']) : null,
      endTime: json['endTime'] != null ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['endTime']) : null,
      movie: json['movie'] == null ? null : Movie.fromJson(json['movie'] as Map<String, dynamic>),
      price: json['price'] as int,
      movieFormat: MovieFormat.fromValue(json['movieFormat']),
      invoices: json['invoices'] != null ? (json['invoices'] as List).map((e) => Invoice.fromJson(e)).toList(): [],
      state: GeneralState.fromValue(json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null ? DateTime.parse(json['deletedDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room': room?.toJson(),
      'startTime': DateFormat('dd-MM-yyyy HH:mm:ss').format(startTime!),
      'endTime': DateFormat('dd-MM-yyyy HH:mm:ss').format(endTime!),
      'movie': movie?.toJson(),
      'price': price,
      'movieFormat': movieFormat.value,
      'invoices': invoices.map((e) => e.toJson()).toList(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!) : null,
    };
  }
}
