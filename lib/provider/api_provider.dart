import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class ApiProvider extends ChangeNotifier {
  late bool _success;
  late String _httpStatus;
  late int _httpStatusCode;
  late DateTime _timestamp;
  late String? _message;
  dynamic _data;

  bool get success => _success;
  String get httpStatus => _httpStatus;
  int get httpStatusCode => _httpStatusCode;
  DateTime get timestamp => _timestamp;
  String? get message => _message;
  dynamic get data => _data;

  static final ApiProvider _instance = ApiProvider._();

  factory ApiProvider(BuildContext context) {
    return _instance;
  }

  ApiProvider._();

  static ApiProvider get instance => _instance;

  // asign value to properties
  void _assignValue(jsonData) {
    _success = jsonData['success'];
    _httpStatus = jsonData['httpStatus'];
    _httpStatusCode = jsonData['httpStatusCode'];
    _timestamp = DateFormat('dd-MM-yyyy HH:mm:ss').parse(jsonData['timestamp']);
    _message = jsonData['message'];
    _data = jsonData['data'];

    notifyListeners();
  }

  Future<void> post(
    uri, {
    required headers,
    required body,
  }) async {
    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    // decode response body with utf8
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    _assignValue(jsonData);
  }

  Future<void> get(
    uri, {
    required headers,
  }) async {
    final response = await http.get(
      uri,
      headers: headers,
    );

    // decode response body with utf8
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    _assignValue(jsonData);
  }

  Future<void> put(
    uri, {
    required headers,
    required body,
  }) async {
    final response = await http.put(
      uri,
      headers: headers,
      body: body,
    );

    // decode response body with utf8
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    _assignValue(jsonData);
  }

  Future<void> delete(
    uri, {
    required headers,
  }) async {
    final response = await http.delete(
      uri,
      headers: headers,
    );

    // decode response body with utf8
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    _assignValue(jsonData);
  }
}
