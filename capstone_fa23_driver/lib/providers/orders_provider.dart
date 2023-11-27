import 'dart:io';

import 'package:capstone_fa23_driver/core/enums/transaction_status.dart';
import 'package:capstone_fa23_driver/core/models/order_model.dart';
import 'package:capstone_fa23_driver/helpers/api_helper.dart';
import 'package:capstone_fa23_driver/helpers/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

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
              TransactionStatus.isOngoing(element.currentOrderStatus) &&
              DateTimeHelper.isToday(element.expectedShippingDate))
          .toList();
      _history = List<Order>.from(
              response.result["data"].map((e) => Order.fromJson(e)))
          .where((element) =>
              TransactionStatus.isCompleted(element.currentOrderStatus))
          .toList();
      for (var order in _orders) {
        var location = await _getLatLng(order);
        order.lat = location.latitude;
        order.lng = location.longitude;
      }
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

  Future<LatLng> _getLatLng(Order order) async {
    final response = await ApiClient().get("/orders/${order.id}");
    if (response.statusCode == HttpStatus.ok) {
      _order = Order.fromJsonDetail(response.result);
      return LatLng(_order.lat ?? 0, _order.lng ?? 0);
    } else {
      throw Exception("Failed to load order ${order.id}");
    }
  }

  Future<void> completeOrder() async {
    final response = await ApiClient().put("/orders/${_order.id}/status", {
      "status": _order.currentOrderStatus.index + 1,
      "description": "Đã hoàn thành đơn hàng"
    });
    if (response.statusCode == HttpStatus.noContent ||
        response.statusCode == HttpStatus.ok) {
      notifyListeners();
    } else {
      throw Exception("Failed to complete order ${_order.id}");
    }
  }

  Future<void> calculateRoutes(LatLng currentLocation) async {
    final response = await ApiClient().get("/routes");
    if (response.statusCode == HttpStatus.ok) {
      // var responseData = json.decode(response.body);
    }
  }
}
