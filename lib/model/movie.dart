import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class Movie {
  String _id;
  String name;
  String description;
  String image;
  List<Genre> genres;

  Movie({
    required String id,
    required this.name,
    required this.description,
    required this.image,
    required this.genres,
  }) : _id = id;

  Movie.withoutId({
    required this.name,
    required this.description,
    required this.image,
    required this.genres,
  }) : _id = '';

  Movie.empty()
      : _id = '',
        name = '',
        description = '',
        image = '',
        genres = [];

  String get id => _id;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      genres: (json['genre'] as List).map((e) => Genre.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'name': name,
      'description': description,
      'image': image,
      'genres': genres.map((e) => e.toJson()).toList(),
    };
  }
}
