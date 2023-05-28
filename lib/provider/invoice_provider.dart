import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/invoice.dart';

class InvoiceProvider extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider.instance;

  List<Invoice> _invoices = [];

  List<Invoice> get invoices => _invoices;

  Future<HttpResponse> getInvoices() async {
    HttpResponse response = await _apiProvider.post(
      Uri.parse("$baseUrl/invoice/search"),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer ${AuthenticationService.instance.token}",
      },
      body: jsonEncode({}),
    );

    if (response.success) {
      try {
        _invoices = response.data.map<Invoice>((e) => Invoice.fromJson(e)).toList();
      } catch (e) {
        print(e);
      }
    }

    notifyListeners();

    return response;
  }
}
