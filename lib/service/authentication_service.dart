import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class AuthenticationService {
  AuthenticationService._();

  static final AuthenticationService _instance = AuthenticationService._();

  static final HiveProvider _hiveDataProvider = HiveProvider.instance;

  factory AuthenticationService() => _instance;

  static AuthenticationService get instance => _instance;

  String? _token;

  String? get token => _token;

  Future<void> init() async {
    await Hive.initFlutter();
    // Hive.registerAdapter<UserLoginResponse>(UserLoginResponseAdapter());
    // Hive.registerAdapter<UserInfo>(UserInfoAdapter());
  }

  Future<void> loadToken() async {
    Map response = await _hiveDataProvider.read(table: "user");
    _token = (response.isNotEmpty ? response["token"] : null);
  }

  /// Method to check if user is logged in
  Future<bool> isLoggedIn() async {
    await loadToken();
    return (_token != null && _token!.isNotEmpty);
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    await _hiveDataProvider.insert(table: "user", values: user);
  }

  Future<void> saveToken(String token) async {
    await _hiveDataProvider.insert(table: "user", values: {"token": token});
  }

  /// Method to logout user
  Future<void> logout() async {
    await _hiveDataProvider.delete(table: "user");
  }

  Future<int?> getUserId() async {
    Map response = await _hiveDataProvider.read(table: "user");
    return (response.isNotEmpty ? response["id"] : null);
  }

  Future<String> getCurrentUserEmail() async {
    Map response = await _hiveDataProvider.read(table: "user");
    return (response.isNotEmpty ? response["email"] : null);
  }
}
