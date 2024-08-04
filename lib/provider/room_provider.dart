import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/room/room_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';

class RoomProvider extends ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  final token = AuthenticationService.instance.token;
  Room? _room;

  Room? get room => _room;

  List<Room> _rooms = [];

  List<Room> get rooms => _rooms;

  Future<HttpResponse> getRooms(RoomSearch search) async {
    HttpResponse response = await apiProvider.post(
        Uri.parse('$baseUrl/room/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(search.toJson()));

    try {
      _rooms = response.data.map<Room>((e) => Room.fromJson(e)).toList();
      print(_rooms.length);
    } catch (e) {
      print(e);
    }
    return response;
  }

  Future<Room?> getRoomById(String id) async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/api/room/$id'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _room = Room.fromJson(jsonResponse['data']);
      }

      notifyListeners();
      return _room;
    } catch (_) {
      rethrow;
    }
  }

  Future<HttpResponse> createRoom(Room room) async {
    HttpResponse response = await apiProvider.post(
        Uri.parse('$baseUrl/room/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(room.toJson()),
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> updateRoom(Room room) async {
    HttpResponse response = await apiProvider.put(
      Uri.parse('$baseUrl/room/update'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(room.toJson()),
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> deleteRoom(int id) async {
    HttpResponse response = await apiProvider.delete(
      Uri.parse('$baseUrl/room/delete/$id'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    notifyListeners();
    return response;
  }
}
