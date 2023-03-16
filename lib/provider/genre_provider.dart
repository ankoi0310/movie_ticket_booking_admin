import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class GenreProvider extends ChangeNotifier {
  Genre? _genre;

  Genre? get genre => _genre;

  List<Genre> _genres = [];

  List<Genre> get genres => _genres;

  Future<List<Genre>> getGenres() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/genre'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonResponse['data'] as List;
        _genres = data.map((e) => Genre.fromJson(e)).toList();
      }

      notifyListeners();
      return _genres;
    } catch (_) {
      rethrow;
    }
  }

  Future<Genre?> getGenreById(String id) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/api/genre/$id'));

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
        Uri.parse('http://localhost:3000/api/genre'),
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
        Uri.parse('http://localhost:3000/api/genre/${genre.id}'),
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

  Future<void> deleteGenre(String id) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:3000/api/genre/$id'));

      if (response.statusCode == 200) {
        _genres.removeWhere((element) => element.id == id);
      }

      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
