import 'package:hive_flutter/adapters.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/user/user_login.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/hive/hive_provider.dart';

class AuthenticationService {
  AuthenticationService._();

  static final AuthenticationService _instance = AuthenticationService._();

  static final HiveProvider _hiveDataProvider = HiveProvider.instance;

  factory AuthenticationService() => _instance;

  static AuthenticationService get instance => _instance;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<UserLogin>(UserLoginAdapter());
    // await Hive.openBox<UserLogin>("user");
  }

  /// Method to get User
  Future<UserLogin> getUser() async {
    Map<String, dynamic> response = await _hiveDataProvider.read("user");
    return UserLogin.fromJson(response);
  }

  /// Method to check if user is logged in
  Future<bool> isLoggedIn() async {
    String? token = await getToken();
    return (token != null && token.isNotEmpty);
  }

  /// Method to login user
  Future<void> login(UserLogin user) async {
    await _hiveDataProvider.insert("user", user.toJson());
  }

  /// Method to logout user
  Future<void> logout() async {
    await _hiveDataProvider.delete("user");
  }

  Future<int?> getUserId() async {
    Map response = await _hiveDataProvider.read("user");
    return (response.isNotEmpty ? response["id"] : null);
  }

  Future<String?> getToken() async {
    Map response = await _hiveDataProvider.read("user");
    return (response.isNotEmpty ? response["token"] : null);
  }
}
