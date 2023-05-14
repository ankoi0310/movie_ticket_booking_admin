import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/bad_request_exception.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._();

  factory ApiProvider(BuildContext context) {
    return _instance;
  }

  ApiProvider._();

  static ApiProvider get instance => _instance;

  Future<HttpResponse> post(
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
    if (response.statusCode == 200) {
      return HttpResponse.fromJson(jsonData);
    } else {
      throw BadRequestException(jsonData['message']);
    }
  }

  Future<HttpResponse> get(
    uri, {
    required headers,
  }) async {
    final response = await http.get(
      uri,
      headers: headers,
    );

    // decode response body with utf8
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    return HttpResponse.fromJson(jsonData);
  }

  Future<HttpResponse> put(
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
    return HttpResponse.fromJson(jsonData);
  }

  Future<HttpResponse> delete(
    uri, {
    required headers,
  }) async {
    final response = await http.delete(
      uri,
      headers: headers,
    );

    // decode response body with utf8
    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    return HttpResponse.fromJson(jsonData);
  }
}
