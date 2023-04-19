import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/firebase_storage_service.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/string_util.dart';

class MovieProvider with ChangeNotifier {
  Movie? _movie;

  Movie? get movie => _movie;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  FirebaseStorageService firebaseStorageService = FirebaseStorageService();

  Future<List<Movie>> getMovies() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8081/api/v1/movie'));

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

  Future<Movie?> getMovieById(int id) async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8081/api/v1/movie/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _movie = Movie.fromJson(jsonResponse['data']);
      }

      return _movie;
    } catch (_) {
      rethrow;
    }
  }

  Future<Movie?> createMovie(Movie movie, Uint8List imageVerticalBytes,
      Uint8List imageHorizontalBytes) async {
    movie.imageVertical = '/images/${StringUtil.convert(movie.name)}_vertical.jpg';
    movie.imageHorizontal = '/images/${StringUtil.convert(movie.name)}_horizontal.jpg';

    try {
      final response = await http.post(
        Uri.parse('http://localhost:8081/api/v1/movie/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "movie": movie.toJson(),
        }),
      );

      Map httpResponse = jsonDecode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        firebaseStorageService.uploadImage(
           movie.imageVertical, imageVerticalBytes);
        firebaseStorageService.uploadImage(
            movie.imageHorizontal, imageHorizontalBytes);

        _movie = Movie.fromJson(httpResponse['data']);
      } else if (response.statusCode == 400) {
        throw BadRequestException(httpResponse['message']);
      }
      return _movie;
    } catch (_) {
      print('error: $_');
      rethrow;
    }
  }

  Future<Movie?> updateMovie(Movie movie) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:3000/api/movie/$movie.id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({}),
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

  Future<void> deleteMovie(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('http://localhost:3000/api/movie/$id'));

      if (response.statusCode == 200) {
        _movies.removeWhere((element) => element.id == id);
      }
    } catch (_) {
      rethrow;
    }
  }
}
