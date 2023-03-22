import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/seat.dart';

class Room {
  String id;
  String name;
  Branch branch;
  int totalSeat;
  List<int> marginLeftCols = [];
  List<int> marginRightCols = [];
  String createdAt;
  String updatedAt;
  List<Seat> seats = [];

  Room({
    required this.id,
    required this.name,
    required this.branch,
    required this.totalSeat,
    required this.marginLeftCols,
    required this.marginRightCols,
    required this.createdAt,
    required this.updatedAt,
    required this.seats,
  });

  Room.withoutId({
    required this.name,
    required this.branch,
    required this.totalSeat,
    required this.marginLeftCols,
    required this.marginRightCols,
    required this.createdAt,
    required this.updatedAt,
    required this.seats,
  }) : id = '';

  Room.empty()
      : id = '',
        name = '',
        branch = Branch.empty(),
        totalSeat = 0,
        marginLeftCols = [],
        marginRightCols = [],
        createdAt = '',
        updatedAt = '',
        seats = [];

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      branch: Branch.fromJson(json['branch']),
      totalSeat: json['totalSeat'],
      marginLeftCols: json['marginLeftCols'] != null
          ? (json['marginLeftCols'] as List).map((e) => e as int).toList()
          : [],
      marginRightCols: json['marginRightCols'] != null
          ? (json['marginRightCols'] as List).map((e) => e as int).toList()
          : [],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      seats: json['seats'] != null
          ? (json['seats'] as List).map((e) => Seat.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'branch': branch.toJson(),
      'totalSeat': totalSeat,
      'marginLeftCols': marginLeftCols,
      'marginRightCols': marginRightCols,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'seats': seats.map((e) => e.toJson()).toList(),
    };
  }
}
