import 'package:hive/hive.dart';

class UserLoginRequest {
  String email;
  String password;

  UserLoginRequest({
    required this.email,
    required this.password,
  });

  factory UserLoginRequest.fromJson(Map<String, dynamic> json) {
    return UserLoginRequest(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

@HiveType(typeId: 0)
class UserLoginResponse {
  @HiveField(0)
  int userId;

  @HiveField(1)
  String email;

  @HiveField(2)
  String token;

  UserLoginResponse({
    required this.userId,
    required this.email,
    required this.token,
  });

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) {
    return UserLoginResponse(
      userId: json['userId'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'token': token,
    };
  }
}