import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/movie/movie_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/firebase_storage_service.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/util/string_util.dart';

class MovieProvider with ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  final token = AuthenticationService.instance.token;
  Movie? _movie;

  Movie? get movie => _movie;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  FirebaseStorageService firebaseStorageService = FirebaseStorageService();

  Future<HttpResponse> getMovies(MovieSearch search) async {
    HttpResponse response = await apiProvider.post(Uri.parse('$baseUrl/movie/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(search.toJson()));

    try {
      _movies = response.data.map<Movie>((e) => Movie.fromJson(e)).toList();
    } catch (e) {}

    return response;
  }

  Future<HttpResponse> getMovieById(int id) async {
    HttpResponse response = await apiProvider.post(Uri.parse('$baseUrl/movie/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(id));

    _movie = Movie.fromJson(response.data);

    return response;
  }

  Future<HttpResponse?> createMovie(Movie movie, Uint8List imageVerticalBytes, Uint8List imageHorizontalBytes) async {
    movie.imageVertical = '/images/${StringUtil.convert(movie.name)}_vertical.jpg';
    movie.imageHorizontal = '/images/${StringUtil.convert(movie.name)}_horizontal.jpg';
    HttpResponse response = await apiProvider.post(
      Uri.parse('$baseUrl/movie/create'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "movie": movie.toJson(),
      }),
    );

    if (response.success) {
      await firebaseStorageService.uploadImage(movie.imageVertical, imageVerticalBytes);
      await firebaseStorageService.uploadImage(movie.imageHorizontal, imageHorizontalBytes);

      notifyListeners();
    } else {
      throw BadRequestException(response.message);
    }
  }

  Future<HttpResponse?> updateMovie(Movie movie, Uint8List imageVerticalBytes, Uint8List imageHorizontalBytes) async {
    movie.imageVertical = '/images/${StringUtil.convert(movie.name)}_vertical.jpg';
    movie.imageHorizontal = '/images/${StringUtil.convert(movie.name)}_horizontal.jpg';

    HttpResponse response = await apiProvider.put(
      Uri.parse('$baseUrl/movie/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(movie.toJson()),
    );

    if (response.success) {
      await firebaseStorageService.uploadImage(movie.imageVertical, imageVerticalBytes);
      await firebaseStorageService.uploadImage(movie.imageHorizontal, imageHorizontalBytes);

      notifyListeners();
    } else {
      throw BadRequestException(response.message);
    }
  }

  Future<HttpResponse?> deleteMovie(int id) async {
    HttpResponse response = await apiProvider.delete(
      Uri.parse('$baseUrl/movie/delete/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.success) {
      notifyListeners();
    } else {
      throw BadRequestException(response.message);
    }
  }
}
