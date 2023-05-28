import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/constant/api_constant.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/handler/http_response.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/product.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/api_provider.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/service/authentication_service.dart';

class ProductProvider extends ChangeNotifier {
  final apiProvider = ApiProvider.instance;
  final token = AuthenticationService.instance.token;
  Product? _product;

  List<Product> _products = [];

  Product? get product => _product;

  List<Product> get products => _products;

  Future<HttpResponse> createProduct(Product product) async {
    HttpResponse response = await apiProvider.post(
      Uri.parse("$baseUrl/product/create"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "product": product.toJson()
      })
    );

    notifyListeners();
    return response;
  }

  Future<HttpResponse> getProducts() async {
    HttpResponse response = await apiProvider.get(
        Uri.parse("$baseUrl/product/search"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );

    _products = response.data.map<Product>((e) => Product.fromJson(e)).toList();

    return response;
  }

  Future<HttpResponse> updateProduct(Product product) async {
    HttpResponse response = await apiProvider.put(
      Uri.parse("$baseUrl/product/update"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(product.toJson())
    );

    // _products = response.data.map<Product>((e) => Product.fromJson(e)).toList();
    notifyListeners();
    return response;
  }
  Future<HttpResponse> deleteProduct(int id) async {
    HttpResponse response = await apiProvider.delete(
      Uri.parse("$baseUrl/product/delete/$id"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    notifyListeners();

    return response;
  }
}