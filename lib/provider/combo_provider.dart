import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/combo.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/api_provider.dart';

class ComboProvider extends ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  final token = AuthenticationService.instance.token;
  Combo? _combo;

  List<Combo> _combos = [];

  Combo? get combo => _combo;

  List<Combo> get combos => _combos;

  Future<HttpResponse> createCombo(Combo combo) async {
    HttpResponse response = await apiProvider.post(
      Uri.parse("$baseUrl/combo/create"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({"combo": combo.toJson()}),
    );

    notifyListeners();

    return response;
  }

  Future<HttpResponse> getCombos() async {
    HttpResponse response = await apiProvider.post(
      Uri.parse("$baseUrl/combo/search"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({}),
    );
    _combos = response.data.map<Combo>((e) => Combo.fromJson(e)).toList();
    return response;
  }

  Future<HttpResponse> updateCombo(Combo combo) async {
    HttpResponse response = await apiProvider.put(
      Uri.parse("$baseUrl/combo/update"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(combo.toJson()),
    );

    notifyListeners();

    return response;
  }

  Future<HttpResponse> deleteCombo(int id) async {
    HttpResponse response = await apiProvider.delete(
      Uri.parse("$baseUrl/combo/delete/$id"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    notifyListeners();
    return response;
  }
}
