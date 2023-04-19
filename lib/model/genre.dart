import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';

class Genre extends General {
  String name;
  List<Movie> movies;

  Genre({
    required int id,
    required this.name,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
    required this.movies,
  }) : super(
      id: id,
      state: state,
      createdDate: createdDate,
      modifiedDate: modifiedDate,
      deletedDate: deletedDate);

  Genre.empty()
      : name = '',
        movies = [],
        super.empty();


  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      movies: json['movies'] != null
          ? (json['movies'] as List)
          .map((e) => Movie.fromJson(e))
          .toList()
          : [],
      state: GeneralState.values.firstWhere((e) => e.value == json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null
          ? DateTime.parse(json['deletedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'movies': movies.map((e) => e.toJson()).toList(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }


}
