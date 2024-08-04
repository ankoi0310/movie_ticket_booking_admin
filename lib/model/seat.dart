import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';

enum SeatType {
  normal('NORMAL'),
  couple('COUPLE');

  final String value;

  const SeatType(this.value);

  factory SeatType.fromValue(String value) {
    return SeatType.values.firstWhere((e) => e.value == value);
  }
}

class Seat extends General {
  String code;
  bool isSeat;
  int columnIndex;
  int col;
  int rowIndex;
  int row;
  SeatType seatType;
  Room? room;

  Seat({
    required int id,
    required this.code,
    required this.isSeat,
    required this.columnIndex,
    required this.col,
    required this.rowIndex,
    required this.row,
    required this.seatType,
    required this.room,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(
          id: id,
          state: state,
          createdDate: createdDate,
          modifiedDate: modifiedDate,
          deletedDate: deletedDate,
        );

  Seat.empty()
      : code = '',
        isSeat = false,
        columnIndex = 0,
        col = 0,
        rowIndex = 0,
        row = 0,
        seatType = SeatType.normal,
        room = Room.empty(),
        super.empty();

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'],
      code: json['code'],
      isSeat: json['isSeat'],
      columnIndex: json['columnIndex'],
      col: json['col'],
      rowIndex: json['rowIndex'],
      row: json['row'],
      seatType: SeatType.fromValue(json['seatType']),
      room: json['room'] == null ? null : Room.fromJson(json['room']),
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
      'code': code,
      'isSeat': isSeat,
      'columnIndex': columnIndex,
      'col': col,
      'rowIndex': rowIndex,
      'row': row,
      'seatType': seatType.value,
      'room': room == null ? null : room!.toJson(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }

  factory Seat.initialize({
    required String code,
    required int columnIndex,
    required int col,
    required int rowIndex,
    required int row,
    required SeatType type,
  }) {
    return Seat(
      id: 0,
      code: code,
      isSeat: true,
      columnIndex: columnIndex,
      col: col,
      rowIndex: rowIndex,
      row: row,
      seatType: type,
      room: null,
      state: GeneralState.active,
      createdDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      deletedDate: null,
    );
  }
}
