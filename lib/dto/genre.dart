import 'package:movie_ticket_booking_admin_flutter_nlu/dto/general.dart';

class Genre extends General {
  String name;

  Genre({
    required int id,
    required this.name,
    required GeneralState state,
    required DateTime createdDate,
    required DateTime modifiedDate,
    required DateTime? deletedDate,
  }) : super(id: id, state: state, createdDate: createdDate, modifiedDate: modifiedDate, deletedDate: deletedDate);

  Genre.empty()
      : name = '',
        super.empty();

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['_id'],
      name: json['name'],
      state: GeneralState.values.firstWhere((e) => e.value == json['state']),
      createdDate: DateTime.parse(json['createdDate']),
      modifiedDate: DateTime.parse(json['modifiedDate']),
      deletedDate: json['deletedDate'] != null ? DateTime.parse(json['deletedDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'state': state.value,
      'createdDate': createdDate.toString(),
      'modifiedDate': modifiedDate.toString(),
      'deletedDate': deletedDate.toString(),
    };
  }
}
