import 'dart:io';

import 'package:capstone_fa23_customer/core/models/order_model.dart';
import 'package:capstone_fa23_customer/helpers/api_helper.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  late List<Order> _orders;
  late Order _order;
  bool _isLoading = true;

  List<Order> get orders => _orders;
  Order get order => _order;
  bool get isLoading => _isLoading;

  void clear() {
    _isLoading = true;
  }

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

  Future<Order> getOrder(String id) async {
    final response = await ApiClient().get("/orders/$id");
    if (response.statusCode == HttpStatus.ok) {
      _order = Order.fromJsonDetail(response.result);
      return _order;
    } else {
      throw Exception("Failed to load order $id");
    }
  }

  Future<void> feedBack(String rate, String comment) async {
    final response = await ApiClient().post("/orders/${_order.id}/feedbacks", {
      "rate": rate,
      "comment": comment,
    });
    if (response.statusCode == HttpStatus.ok) {
      getListOrders();
    } else {
      throw Exception("Lỗi gửi feedback đơn hàng ${_order.id}");
    }
  }
}
