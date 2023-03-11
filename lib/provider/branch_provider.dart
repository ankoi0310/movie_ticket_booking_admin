import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/model/branch.dart';

class BranchProvider with ChangeNotifier {
  Branch? _branch;

  Branch? get branch => _branch;

  List<Branch> _branches = [];

  List<Branch> get branches => _branches;

  Future<List<Branch>> getBranches() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/branch'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonResponse['data'] as List;
        _branches = data.map((e) => Branch.fromJson(e)).toList();
      }

      return _branches;
    } catch (_) {
      rethrow;
    }
  }

  Future<Branch?> getBranchById(int id) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/branches/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _branch = Branch.fromJson(jsonResponse['data']);
      }

      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<Branch?> createBranch({required String name}) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/branches'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _branch = Branch.fromJson(jsonResponse['data']);
      }

      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<Branch?> updateBranch({required int id, required String name}) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/api/branches/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': name,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _branch = Branch.fromJson(jsonResponse['data']);
      }

      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteBranch(String id) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:3000/api/branches/$id'));

      if (response.statusCode == 200) {
        _branches.removeWhere((element) => element.id == id);
      }
    } catch (_) {
      rethrow;
    }
  }
}
