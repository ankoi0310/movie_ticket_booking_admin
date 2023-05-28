import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/branch/branch_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/branch.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/api_provider.dart';

class BranchProvider with ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  final token = AuthenticationService.instance.token;
  Branch? _branch;

  Branch? get branch => _branch;

  List<Branch> _branches = [];

  List<Branch> get branches => _branches;

  Future<HttpResponse> getBranches(BranchSearch search) async {
    HttpResponse response = await apiProvider.post(
      Uri.parse('$baseUrl/branch/search'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(search.toJson()),
    );

    try {
      _branches = response.data.map<Branch>((e) => Branch.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }

    return response;
  }

  Future<Branch?> getBranchById(int id) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/branch/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _branch = Branch.fromJson(jsonResponse['data']);
      }

      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<HttpResponse> createBranch(Branch branch) async {
    HttpResponse response = await apiProvider.post(
      Uri.parse('$baseUrl/branch/create'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(branch.toJson()),
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> updateBranch(Branch branch) async {
    HttpResponse response = await apiProvider.put(
      Uri.parse('$baseUrl/branch/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(branch.toJson()),
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> deleteBranch(int id) async {
    HttpResponse response = await apiProvider.delete(
      Uri.parse('$baseUrl/branch/delete/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    notifyListeners();
    return response;
  }
}
