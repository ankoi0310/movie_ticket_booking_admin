import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/seat.dart';

enum RoomState {
  available("AVAILABLE"),
  occupied("OCCUPIED"),
  reversed("RESERVED"),
  outOfService("OUT_OF_SERVICE"),
  cleaning("CLEANING"),
  paused("PAUSED");

  final String value;

  const RoomState(this.value);

  factory RoomState.fromValue(String value) {
    return RoomState.values.firstWhere((e) => e.value == value);
  }
}

class Room extends General {
  String name;
  Branch branch;
  int totalSeat;
  List<int> marginLeftCols = [];
  List<int> marginRightCols = [];
  RoomState status;
  List<Seat> seats = [];

  Room({
    required int id,
    required this.name,
    required this.branch,
    required this.totalSeat,
    required this.marginLeftCols,
    required this.marginRightCols,
    required this.seats,
    required this.status,
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

  Room.empty()
      : name = '',
        branch = Branch.empty(),
        totalSeat = 0,
        marginLeftCols = [],
        marginRightCols = [],
        seats = [],
        status = RoomState.available,
        super.empty();

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      branch: Branch.fromJson(json['branch']),
      totalSeat: json['totalSeat'],
      marginLeftCols: json['marginLeftCols'].cast<int>(),
      marginRightCols: json['marginRightCols'].cast<int>(),
      seats: (json['seats'] as List).map((e) => Seat.fromJson(e)).toList(),
      status: RoomState.fromValue(json['status']),
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
      'branch': branch.toJson(),
      'totalSeat': totalSeat,
      'marginLeftCols': marginLeftCols,
      'marginRightCols': marginRightCols,
      'seats': seats.map((e) => e.toJson()).toList(),
      'status': status.value,
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }
}
