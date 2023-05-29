import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';

enum StatisticValue {
  revenue('REVENUE'),
  ticket('TICKET'),
  movie('MOVIE'),
  branch('BRANCH');

  final String name;

  const StatisticValue(this.name);
}

enum StatisticTimeline {
  day('DAY'),
  week('WEEK'),
  month('MONTH'),
  year('YEAR');

  final String name;

  const StatisticTimeline(this.name);
}

class StatisticFilter {
  String value;
  String timeline;
  int movieId;
  int branchId;

  StatisticFilter({
    required this.value,
    required this.timeline,
    this.movieId = 0,
    this.branchId = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'timeline': timeline,
      'movieId': movieId,
      'branchId': branchId,
    };
  }
}

class StatisticProvider with ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;
  final token = AuthenticationService.instance.token;

  Future<HttpResponse> getStatistic(StatisticFilter filter) async {
    print(filter.toJson());
    HttpResponse response = await _apiProvider.post(
      Uri.parse('$baseUrl/statistic'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(filter.toJson()),
    );

    print(response.data);

    notifyListeners();
    return response;
  }
}
