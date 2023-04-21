import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class GenreProvider extends ChangeNotifier {
  Genre? _genre;

  Genre? get genre => _genre;

  List<Genre> _genres = [];

  List<Genre> get genres => _genres;

  Future<List<Genre>> getGenres() async {
    try {
      final response = await http.post(
          Uri.parse('$baseUrl/genre/search'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({})
      );

      // decode response body to json with utf8
      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        final data = jsonResponse['data'] as List;
        _genres = data.map((e) => Genre.fromJson(e)).toList();
      }

      notifyListeners();
      return _genres;
    } catch (_) {
      print('error: $_');
      rethrow;
    }
  }

  Future<Genre?> getGenreById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/genre/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _genre = Genre.fromJson(jsonResponse['data']);
      }

      notifyListeners();
      return _genre;
    } catch (_) {
      rethrow;
    }
  }

  Future<Genre?> createGenre(Genre genre) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/genre'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': genre.name,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _genre = Genre.fromJson(jsonResponse['data']);
      }

      notifyListeners();
      return _genre;
    } catch (_) {
      rethrow;
    }
  }

  Future<Genre?> updateGenre(Genre genre) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/genre/${genre.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': genre.name,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _genre = Genre.fromJson(jsonResponse['data']);
      }

      notifyListeners();
      return _genre;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteGenre(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/genre/$id'));

      if (response.statusCode == 200) {
        _genres.removeWhere((element) => element.id == id);
      }

      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
