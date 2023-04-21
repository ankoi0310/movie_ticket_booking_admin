import 'package:intl/intl.dart';

import 'general.dart';
import 'genre.dart';

enum MovieState {
  upcoming('UPCOMING'),
  nowShowing("NOW_SHOWING"),
  comingSoon("COMING_SOON");

  final String value;

  const MovieState(this.value);

  factory MovieState.fromValue(String value) {
    return MovieState.values.firstWhere((e) => e.value == value);
  }
}

enum MovieFormat {
  twoD('TWO_D'),
  threeD('THREE_D'),
  fourD('EIGHT_D'),
  voiceOver('VOICE_OVER');

  final String value;

  const MovieFormat(this.value);

  factory MovieFormat.fromValue(String value) {
    return MovieFormat.values.firstWhere((e) => e.value == value);
  }
}

class Movie extends General {
  String name;
  String storyLine;
  String imageVertical;
  String imageHorizontal;
  List<Genre> genres;
  double rating;
  String slug;
  String language;
  String subtitle;
  String country;
  int duration;
  String trailerUrl;
  List<String> actors;
  String director;
  String producer;
  DateTime releaseDate;
  MovieState movieState;
  List<MovieFormat> movieFormats;

  Movie({
    required int id,
    required this.name,
    required this.storyLine,
    required this.imageVertical,
    required this.imageHorizontal,
    required this.genres,
    required this.rating,
    required this.slug,
    required this.language,
    required this.subtitle,
    required this.country,
    required this.duration,
    required this.trailerUrl,
    required this.actors,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.movieState,
    required this.movieFormats,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(
            id: id,
            state: state,
            createdDate: createdDate,
            modifiedDate: modifiedDate,
            deletedDate: deletedDate);

  Movie.empty()
      : name = '',
        storyLine = '',
        imageVertical = '',
        imageHorizontal = '',
        genres = [],
        rating = 0.0,
        slug = '',
        language = '',
        subtitle = '',
        country = '',
        duration = 0,
        trailerUrl = '',
        actors = [],
        director = '',
        producer = '',
        releaseDate = DateTime.now(),
        movieState = MovieState.upcoming,
        movieFormats = [],
        super.empty();

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['name'],
      storyLine: json['storyLine'],
      imageVertical: json['imageVertical'],
      imageHorizontal: json['imageHorizontal'],
      genres: (json['genres'] as List).map((e) => Genre.fromJson(e)).toList(),
      rating: json['rating'],
      slug: json['slug'],
      language: json['language'],
      subtitle: json['subtitle'],
      country: json['country'],
      duration: json['duration'],
      trailerUrl: json['trailerUrl'],
      actors: List<String>.from((json['actors']).toList()),
      director: json['director'],
      producer: json['producer'],
      releaseDate: DateFormat('dd-MM-yyyy').parse(json['releaseDate']),
      movieState:
          MovieState.fromValue(json['movieState'] as String),
      movieFormats: (json['movieFormats'] as List)
          .map((e) => MovieFormat.fromValue(e))
          .toList(),
      state: GeneralState.fromValue(json['state']),
      createdDate: DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['createdDate']),
      modifiedDate:
          DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null
          ? DateTime.parse(json['deletedDate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'storyLine': storyLine,
      'imageVertical': imageVertical,
      'imageHorizontal': imageHorizontal,
      'genres': genres.map((e) => e.toJson()).toList(),
      'rating': rating,
      'slug': slug,
      'language': language,
      'subtitle': subtitle,
      'country': country,
      'duration': duration,
      'trailerUrl': trailerUrl,
      'actors': actors,
      'director': director,
      'producer': producer,
      'releaseDate': DateFormat('dd-MM-yyyy').format(releaseDate),
      'movieState': movieState.value,
      'movieFormats': movieFormats.map((e) => e.value).toList(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }
}
