import 'package:hive/hive.dart';

part 'user_login.g.dart';

@HiveType(typeId: 0)
class UserLogin {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String token;

  UserLogin({
    required this.id,
    required this.email,
    required this.token,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) {
    return UserLogin(
      id: json['userId'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'token': token,
    };
  }
}
