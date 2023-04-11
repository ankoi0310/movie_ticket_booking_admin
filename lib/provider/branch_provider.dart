import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/branch.dart';

class BranchProvider with ChangeNotifier {
  Branch? _branch;

  Branch? get branch => _branch;

  List<Branch> _branches = [];

  List<Branch> get branches => _branches;

  Future<List<Branch>> getBranches() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/branch'));

      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final data = jsonResponse['data'] as List;
        _branches = data.map((e) => Branch.fromJson(e)).toList();
      }

      return _branches;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Branch?> getBranchById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/branch/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _branch = Branch.fromJson(jsonResponse['data']);
      }

      notifyListeners();
      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<Branch?> createBranch(Branch branch) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/branch'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': branch.name,
          'address': branch.address,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _branch = Branch.fromJson(jsonResponse['data']);
      }

      notifyListeners();
      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<Branch?> updateBranch(Branch branch) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/branch'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(branch.toJson()),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _branch = Branch.fromJson(jsonResponse['data']);
        _branches = List.from(_branches);
        _branches[_branches.indexWhere((element) => element.id == branch.id)] = _branch!;

        notifyListeners();
      }

      return _branch;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteBranch(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/branch/$id'));

      if (response.statusCode == 200) {
        _branches.removeWhere((element) => element.id == id);
      }

      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
