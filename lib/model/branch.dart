class Branch {
  String? id;
  String name;
  String address;

  Branch({
    required this.id,
    required this.name,
    required this.address,
  });

  Branch.empty()
      : name = '',
        address = '';

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['_id'],
      name: json['name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'address': address,
    };
  }
}
