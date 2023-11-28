// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';

import 'package:capstone_fa23_driver/core/enums/route_calculation_type.dart';
import 'package:capstone_fa23_driver/core/enums/transaction_status.dart';
import 'package:capstone_fa23_driver/core/models/order_model.dart';
import 'package:capstone_fa23_driver/helpers/api_helper.dart';
import 'package:capstone_fa23_driver/helpers/datetime_helper.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];
  List<Order> _history = [];
  late Order _order;
  bool _isLoading = true;

  List<Order> get orders => _orders;
  List<Order> get history => _history;
  Order get order => _order;
  bool get isLoading => _isLoading;

  void clear() {
    _isLoading = true;
    _orders = [];
    _history = [];
  }

  Future<void> getListOrders(
      {TransactionStatus? status, int size = 10, int page = 1}) async {
    var url = "/orders?Limit=$size&Page=$page";
    if (status != null) {
      url += "&Status=${status.index}";
    }
    final response = await ApiClient().get(url);
    if (response.statusCode == HttpStatus.ok) {
      var orders = List<Order>.from(
              response.result["data"].map((e) => Order.fromJson(e)))
          .where((element) =>
                  TransactionStatus.isOngoing(element.currentOrderStatus)
              // &&
              // DateTimeHelper.isToday(element.expectedShippingDate)
              )
          .toList();
      if (page == 1) {
        _orders = orders;
      } else {
        for (var i = 0; i < orders.length; i++) {
          _orders.add(orders[i]);
        }
      }
      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception("Failed to load orders");
    }
  }

  Future<void> getHistory(
      {TransactionStatus? status, int size = 10, int page = 1}) async {
    var url = "/orders?Limit=$size&Page=$page";
    if (status != null) {
      url += "&Status=${status.index}";
    }
    final response = await ApiClient().get(url);
    if (response.statusCode == HttpStatus.ok) {
      var history = List<Order>.from(
              response.result["data"].map((e) => Order.fromJson(e)))
          .where((element) =>
              TransactionStatus.isCompleted(element.currentOrderStatus))
          .toList();
      if (page == 1) {
        _history = history;
      } else {
        for (var i = 0; i < history.length; i++) {
          _history.add(history[i]);
        }
      }
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

  Future<void> completeOrder() async {
    final response = await ApiClient().put("/orders/${_order.id}/status", {
      "status": _order.currentOrderStatus.index + 1,
      "description": "Đã hoàn thành đơn hàng"
    });
    if (response.statusCode == HttpStatus.noContent ||
        response.statusCode == HttpStatus.ok) {
      getListOrders();
      getHistory();
      notifyListeners();
    } else {
      throw Exception("Failed to complete order ${_order.id}");
    }
  }

  Future<void> calculateRoutes(
      LatLng currentLocation, RouteCalculationType? calculationType) async {
    bool useDuration = calculationType == RouteCalculationType.duration;
    final response = await ApiClient().getRaw(
        "/orders/routes?originLat=${currentLocation.latitude}&originLng=${currentLocation.longitude}&useDuration=$useDuration");
    if (response.statusCode == HttpStatus.ok) {
      var responseData = json.decode(response.body);
      var orders = responseData["result"]["listRoute"]
          .map((e) => {
                "id": e["order"]["id"],
                "no": e["no"],
              })
          .toList();
      orders.sort((a, b) => (a["no"] as int).compareTo(b["no"] as int));
      List<Order> sortedOrder = [];
      for (var ord in orders) {
        var order =
            _orders.where((element) => element.id == ord["id"]).firstOrNull;
        if (order != null) {
          sortedOrder.add(order);
        }
      }
      _orders = sortedOrder;

      notifyListeners();
    } else {
      throw Exception("Tính toán lộ trình thất bại");
    }
  }
}
