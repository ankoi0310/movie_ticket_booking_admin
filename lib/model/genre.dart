class Genre {
  String? id;
  String name;

  Genre({
    this.id,
    required this.name,
  });

  Genre.empty() : name = '';

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}
