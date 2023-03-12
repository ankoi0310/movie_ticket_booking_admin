class Branch {
  String _id;
  String name;
  String address;

  Branch({
    required String id,
    required this.name,
    required this.address,
  }) : _id = id;

  Branch.withoutId({
    required this.name,
    required this.address,
  }) : _id = '';

  String get id => _id;

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'name': name,
      'address': address,
    };
  }
}
