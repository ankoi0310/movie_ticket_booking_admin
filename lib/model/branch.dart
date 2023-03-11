class Branch {
  final String _id;
  final String name;
  final String url;

  Branch({
    required String id,
    required this.name,
    required this.url,
  }) : _id = id;

  String get id => _id;

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['_id'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'name': name,
      'url': url,
    };
  }
}
