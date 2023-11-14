import 'dart:io';

import 'package:capstone_fa23_customer/core/models/order_model.dart';
import 'package:capstone_fa23_customer/helpers/api_helper.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  late List<Order> _orders;
  bool _isLoading = true;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;

  Future<void> getListOrders() async {
    final response = await ApiClient().get("/orders");
    if (response.statusCode == HttpStatus.ok) {
      _orders = List<Order>.from(
          response.result["data"].map((e) => Order.fromJson(e)));
      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception("Failed to load orders");
    }
  }
}
