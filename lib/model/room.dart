import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class Room {
  String id;
  String name;
  Branch branch;
  int totalSeat;
  String createdAt;
  String updatedAt;

  Room({
    required this.id,
    required this.name,
    required this.branch,
    required this.totalSeat,
    required this.createdAt,
    required this.updatedAt,
  });

  Room.withoutId({
    required this.name,
    required this.branch,
    required this.totalSeat,
    required this.createdAt,
    required this.updatedAt,
  }) : id = '';

  Room.empty()
      : id = '',
        name = '',
        branch = Branch.empty(),
        totalSeat = 0,
        createdAt = '',
        updatedAt = '';

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      branch: Branch.fromJson(json['branch']),
      totalSeat: json['totalSeat'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'branch': branch.toJson(),
      'totalSeat': totalSeat,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
