import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/genre/genre_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';

class GenreProvider extends ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  final token = AuthenticationService.instance.token;
  Genre? _genre;

  Genre? get genre => _genre;

  List<Genre> _genres = [];

  List<Genre> get genres => _genres;

  Future<HttpResponse> getGenres(GenreSearch search) async {
    HttpResponse response = await apiProvider.post(Uri.parse('$baseUrl/genre/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(search.toJson()));

    try {
      _genres = response.data.map<Genre>((e) => Genre.fromJson(e)).toList();
    } catch (e) {}

    return response;
  }

  Future<HttpResponse> getGenreById(int id) async {
    HttpResponse response = await apiProvider.get(
      Uri.parse('$baseUrl/genre/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    try {
      _genre = Genre.fromJson(response.data);
    } catch (e) {}

    return response;
  }

  Future<HttpResponse> createGenre(Genre genre) async {
    HttpResponse response = await apiProvider.post(Uri.parse('$baseUrl/genre/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"genre": genre.toJson()}));

    notifyListeners();
    return response;
  }

  Future<HttpResponse> updateGenre(Genre genre) async {
    HttpResponse response = await apiProvider.put(Uri.parse('$baseUrl/genre/update'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(genre.toJson()));

    notifyListeners();
    return response;
  }

  Future<HttpResponse> deleteGenre(int id) async {
    HttpResponse response = await apiProvider.delete(
      Uri.parse('$baseUrl/genre/delete/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    notifyListeners();
    return response;
  }
}
