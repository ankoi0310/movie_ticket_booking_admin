import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/dto/show_time/show_time_search.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/show_time.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/api_provider.dart';

class ShowtimeProvider with ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  List<ShowTime> _showTimes = [];

  ShowTime? _showTime;

  List<ShowTime> get showTimes => _showTimes;

  ShowTime get getShowTime => _showTime!;

  Future<HttpResponse> getAllShowTime(ShowTimeSearch search) async {
    HttpResponse response = await apiProvider.post(Uri.parse('$baseUrl/showtime/search'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(search.toJson()));

    try {
      _showTimes = response.data.map<ShowTime>((e) => ShowTime.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }

    return response;
  }

  Future<HttpResponse> createShowtime(ShowTime showtime) async {
    HttpResponse response = await apiProvider.post(
        Uri.parse('$baseUrl/showtime/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(showtime.toJson())
    );

    notifyListeners();
    return response;
  }
  Future<HttpResponse> updateShowtime(ShowTime showtime) async {
    HttpResponse response = await apiProvider.put(
        Uri.parse('$baseUrl/showtime/update'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(showtime.toJson())
    );


    notifyListeners();
    return response;
  }
  Future<HttpResponse> deleteShowtime(int id) async {
    HttpResponse response = await apiProvider.delete(
        Uri.parse('$baseUrl/showtime/delete/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );

    notifyListeners();
    return response;
  }


}
