class Genre {
  String _id;
  String name;

  Genre({
    required String id,
    required this.name,
  }) : _id = id;

  String get id => _id;

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'name': name,
    };
  }
}

final List<Genre> genres = [
  Genre(id: '1', name: 'Action'),
  Genre(id: '2', name: 'Adventure'),
  Genre(id: '3', name: 'Animation'),
  Genre(id: '4', name: 'Comedy'),
  Genre(id: '5', name: 'Crime'),
  Genre(id: '6', name: 'Documentary'),
  Genre(id: '7', name: 'Drama'),
  Genre(id: '8', name: 'Family'),
  Genre(id: '9', name: 'Fantasy'),
  Genre(id: '10', name: 'History'),
  Genre(id: '11', name: 'Horror'),
  Genre(id: '12', name: 'Music'),
  Genre(id: '13', name: 'Mystery'),
  Genre(id: '14', name: 'Romance'),
  Genre(id: '15', name: 'Science Fiction'),
  Genre(id: '16', name: 'TV Movie'),
  Genre(id: '17', name: 'Thriller'),
  Genre(id: '18', name: 'War'),
  Genre(id: '19', name: 'Western'),
];
