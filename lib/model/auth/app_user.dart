import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/auth/app_role.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/auth/user_info.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/general.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/invoice.dart';

class AppUser extends General{
  String email;
  String phone;
  String password;
  bool enabled;
  bool accountNonLocked;
  String facebookId;
  String googleId;
  List<AppRole> roles;
  UserInfo userInfo;
  List<Invoice> invoices;

  AppUser({
    required int id,
    required this.email,
    required this.phone,
    required this.password,
    required this.enabled,
    required this.accountNonLocked,
    required this.facebookId,
    required this.googleId,
    required this.roles,
    required this.userInfo,
    required this.invoices,
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

  AppUser.empty()
      : email = '',
        phone = '',
        password = '',
        enabled = false,
        accountNonLocked = false,
        facebookId = '',
        googleId = '',
        roles = [],
        userInfo = UserInfo.empty(),
        invoices = [],
        super.empty();

  @override
  bool operator ==(other) {
    return (other is AppUser) && other.id == id && other.email == email && other.password == password;
  }

  @override
  int get hashCode => id.hashCode;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      enabled: json['enabled'],
      accountNonLocked: json['accountNonLocked'],
      facebookId: json['facebookId'],
      googleId: json['googleId'],
      roles: (json['roles'] as List).map((e) => AppRole.fromJson(e)).toList(),
      userInfo: UserInfo.fromJson(json['userInfo']),
      invoices: (json['invoices'] as List).map((e) => Invoice.fromJson(e)).toList(),
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
      'email': email,
      'phone': phone,
      'password': password,
      'enabled': enabled,
      'accountNonLocked': accountNonLocked,
      'facebookId': facebookId,
      'googleId': googleId,
      'roles': roles.map((e) => e.toJson()).toList(),
      'userInfo': userInfo.toJson(),
      'invoices': invoices.map((e) => e.toJson()).toList(),
      'state': state.value,
      'createdDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(createdDate),
      'modifiedDate': DateFormat('dd-MM-yyyy HH:mm:ss').format(modifiedDate),
      'deletedDate': deletedDate != null
          ? DateFormat('dd-MM-yyyy HH:mm:ss').format(deletedDate!)
          : null,
    };
  }

}