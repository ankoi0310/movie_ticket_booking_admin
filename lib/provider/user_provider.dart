import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/auth/app_user.dart';

class UserProvider with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;

  AppUser? _appUser;

  List<AppUser> _appUsers = [];

  AppUser? get appUser => _appUser;

  List<AppUser> get appUsers => _appUsers;

  Future<HttpResponse> getAllUser() async {
    HttpResponse response = await _apiProvider.post(
      Uri.parse('$baseUrl/user/search'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationService.instance.token}',
      },
      body: jsonEncode({}),
    );

    if (response.success) {
      _appUsers = response.data.map<AppUser>((e) => AppUser.fromJson(e)).toList();
    }

    notifyListeners();

    return response;
  }

  Future<HttpResponse> lockUser(int id) async {
    HttpResponse response = await _apiProvider.post(
      Uri.parse('$baseUrl/user/lock/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthenticationService.instance.token}',
      },
      body: jsonEncode({}),
    );

    if (response.success) {
      _appUsers.firstWhere((element) => element.id == id).accountNonLocked = !_appUsers.firstWhere((element) => element.id == id).accountNonLocked;
    }
    notifyListeners();

    return response;
  }
}
