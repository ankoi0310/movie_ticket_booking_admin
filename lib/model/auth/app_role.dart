import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/auth/app_user.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';

class AppRole extends General{
  String name;
  List<AppUser> users;

  AppRole({
    required int id,
    required this.name,
    required this.users,
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

  AppRole.empty()
      : name = '',
        users = [],
        super.empty();

  @override
  bool operator ==(other) {
    return (other is AppRole) && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  factory AppRole.fromJson(Map<String, dynamic> json) {
    return AppRole(
      id: json['id'],
      name: json['name'],
      users: json['users'] != null
          ? (json['users'])
          .map((e) => AppUser.fromJson(e))
          .toList()
          : [],
      state: GeneralState.values.firstWhere((e) => e.value == json['state']),
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
      'users': users.map((e) => e.toJson()).toList(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }
}