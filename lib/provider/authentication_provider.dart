import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';

class AuthenticationProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;
  final AuthenticationService _authenticationService = AuthenticationService.instance;

  Future<HttpResponse> login(UserLoginRequest loginRequest) async {
    HttpResponse response = await _apiProvider.post(
      Uri.parse('$baseUrl/admin/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': loginRequest.email,
        'password': loginRequest.password,
      }),
    );

    if (response.success) {
      UserLoginResponse userLogin = UserLoginResponse.fromJson(response.data);
      await _authenticationService.saveUser(userLogin.toJson());
    }

    notifyListeners();
    return response;
  }

  Future<void> logout() async {
    await _authenticationService.logout();
    notifyListeners();
  }
}
