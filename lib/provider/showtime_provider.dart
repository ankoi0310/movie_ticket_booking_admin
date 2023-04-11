import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class ShowtimeProvider with ChangeNotifier {
  Showtime? _showtime;

  Showtime? get showtime => _showtime;

  List<Showtime> _showtimes = [];

  List<Showtime> get showtimes => _showtimes;

  Future<List<Showtime>> getShowtimes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/showtime'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonResponse['data'] as List;
        _showtimes = data.map((e) => Showtime.fromJson(e)).toList();
      }

      notifyListeners();
      return _showtimes;
    } catch (_) {
      rethrow;
    }
  }

  Future<Showtime?> getShowtimeById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/showtime/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _showtime = Showtime.fromJson(jsonResponse['data']);
      }

      notifyListeners();
      return _showtime;
    } catch (_) {
      rethrow;
    }
  }

  Future<Showtime?> createShowtime(Showtime showtime) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/showtime'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'movie_id': showtime.movie.id,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _showtime = Showtime.fromJson(jsonResponse['data']);
      }

      notifyListeners();
      return _showtime;
    } catch (_) {
      rethrow;
    }
  }

  Future<Showtime?> updateShowtime(Showtime showtime) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/showtime/${showtime.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'movie_id': showtime.movie.id,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _showtime = Showtime.fromJson(jsonResponse['data']);
      }

      notifyListeners();
      return _showtime;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteShowtime(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/showtime/$id'));

      if (response.statusCode == 200) {
        _showtimes.removeWhere((element) => element.id == id);
      }

      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
