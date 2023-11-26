import 'dart:io';

import 'package:capstone_fa23_driver/core/enums/transaction_status.dart';
import 'package:capstone_fa23_driver/core/models/order_model.dart';
import 'package:capstone_fa23_driver/helpers/api_helper.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  late List<Order> _orders;
  late List<Order> _history;
  late Order _order;
  bool _isLoading = true;

  List<Order> get orders => _orders;
  List<Order> get history => _history;
  Order get order => _order;
  bool get isLoading => _isLoading;

  void clear() {
    _isLoading = true;
  }

  Future<void> getListOrders({TransactionStatus? status}) async {
    var url = "/orders";
    if (status != null) {
      url += "?Status=${status.index}";
    }
    final response = await ApiClient().get(url);
    if (response.statusCode == HttpStatus.ok) {
      _orders = List<Order>.from(
              response.result["data"].map((e) => Order.fromJson(e)))
          .where((element) =>
              TransactionStatus.isOngoing(element.currentOrderStatus))
          .toList();
      _history = List<Order>.from(
              response.result["data"].map((e) => Order.fromJson(e)))
          .where((element) =>
              TransactionStatus.isCompleted(element.currentOrderStatus))
          .toList();
      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception("Failed to load orders");
    }
  }

  Future<void> getOrder(String id) async {
    final response = await ApiClient().get("/orders/$id");
    if (response.statusCode == HttpStatus.ok) {
      _order = Order.fromJsonDetail(response.result);
    } else {
      throw Exception("Failed to load order $id");
    }
  }
}
