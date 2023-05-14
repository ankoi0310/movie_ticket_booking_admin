import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/seat.dart';

enum RoomType {
  normal('NORMAL'),
  vip('VIP');

  final String value;

  const RoomType(this.value);

  factory RoomType.fromValue(String value) {
    return RoomType.values.firstWhere((e) => e.value == value);
  }
}

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
  int row;
  int col;
  int totalSeat;
  List<int> laneRows;
  List<int> laneCols;
  RoomState roomState;
  RoomType type;
  List<Seat> seats = [];


  Room({
    required int id,
    required this.name,
    required this.branch,
    required this.row,
    required this.col,
    required this.laneRows,
    required this.laneCols,
    required this.totalSeat,
    required this.seats,
    required this.roomState,
    required this.type,
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
        row = 0,
        col = 0,
        laneRows = [],
        laneCols = [],
        totalSeat = 0,
        seats = [],
        type = RoomType.normal,
        roomState = RoomState.available,
        super.empty();
  @override
  bool operator ==(other) {
    return (other is Room) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      branch: Branch.fromJson(json['branch']),
      row: json['row'],
      col: json['col'],
      laneRows: List<int>.from((json['laneRows']).toList()),
      laneCols:List<int>.from((json['laneCols']).toList()),
      totalSeat: json['totalSeat'],
      seats: (json['seats'] as List).map((e) => Seat.fromJson(e)).toList(),
      roomState: RoomState.fromValue(json['roomState']),
      type: RoomType.fromValue(json['type']),
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
      'row': row,
      'col': col,
      'laneCols': laneCols,
      'laneRows': laneCols,
      'seats': seats.map((e) => e.toJson()).toList(),
      'roomState': roomState.value,
      'type': type.value,
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }
}
