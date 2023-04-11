import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class RoomProvider extends ChangeNotifier {
  Room? _room;

  Room? get room => _room;

  List<Room> _rooms = [];

  List<Room> get rooms => _rooms;

  Future<List<Room>> getRooms() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/room'));

      Map jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = jsonResponse['data'] as List;
        _rooms = data.map((e) => Room.fromJson(e)).toList();
      }

      notifyListeners();
      return _rooms;
    } catch (_) {
      rethrow;
    }
  }

  Future<Room?> getRoomById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/room/$id'));

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

  Future<Room?> createRoom(Room newRoom) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/room'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': newRoom.name,
          'branchId': newRoom.branch.id,
          'totalSeat': newRoom.totalSeat,
        }),
      );

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

  Future<Room?> updateRoom(Room room) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/room/${room.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': room.name,
          'branch': room.branch,
          'totalSeat': room.totalSeat,
        }),
      );

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

  Future<void> deleteRoom(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/room/$id'));

      if (response.statusCode == 200) {
        _rooms.removeWhere((element) => element.id == id);
      }

      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
