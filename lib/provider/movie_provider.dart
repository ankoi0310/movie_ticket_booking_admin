import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class MovieProvider with ChangeNotifier {
  Movie? _movie;

  Movie? get movie => _movie;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  Future<List<Movie>> getMovies() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/movie'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonResponse['data'] as List;
        _movies = data.map((e) => Movie.fromJson(e)).toList();
      }

      return _movies;
    } catch (_) {
      rethrow;
    }
  }

  Future<Movie?> getMovieById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/movie/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _movie = Movie.fromJson(jsonResponse['data']);
      }

      return _movie;
    } catch (_) {
      rethrow;
    }
  }

  Future<Movie?> createMovie(Movie movie) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/movie'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': movie.name,
          'description': movie.description,
          'image': movie.image,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        _movie = Movie.fromJson(jsonResponse['data']);
      }

      return _movie;
    } catch (_) {
      rethrow;
    }
  }

  Future<Movie?> updateMovie(Movie movie) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/movie/$movie.id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': movie.name,
          'description': movie.description,
          'image': movie.image,
        }),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _movie = Movie.fromJson(jsonResponse['data']);
      }

      return _movie;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> deleteMovie(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/movie/$id'));

      if (response.statusCode == 200) {
        _movies.removeWhere((element) => element.id == id);
      }
    } catch (_) {
      rethrow;
    }
  }
}
