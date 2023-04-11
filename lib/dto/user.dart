class AppUser {
  String _id;
  String email;
  String password;
  UserInfo userInfo;

  AppUser({
    required String id,
    required this.email,
    required this.password,
    required this.userInfo,
  }) : _id = id;

  AppUser.withoutId({
    required this.email,
    required this.password,
    required this.userInfo,
  }) : _id = '';

  String get id => _id;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      userInfo: UserInfo.fromJson(json['userInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'email': email,
      'password': password,
      'userInfo': userInfo.toJson(),
    };
  }
}

class UserInfo {
  String _id;

  UserInfo({
    required String id,
  }) : _id = id;

  String get id => _id;

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
    };
  }
}
