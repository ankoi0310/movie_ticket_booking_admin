import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/user/user_login.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/user/user_register.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/authentication_service.dart';

import 'api_provider.dart';

class AuthenticationProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;
  final AuthenticationService _authentacationService = AuthenticationService.instance;

  Future<bool> register(UserRegister userRegister) async {
    await _apiProvider.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: userRegister.toJson(),
    );

    if (_apiProvider.success) {
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  Future<bool> login(String email, String password) async {
    await _apiProvider.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (_apiProvider.success) {
      UserLogin userLogin = UserLogin.fromJson(_apiProvider.data);
      await _authentacationService.login(userLogin);

      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }
}
