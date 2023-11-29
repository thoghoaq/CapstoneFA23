// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:io';

import 'package:capstone_fa23_driver/core/enums/route_calculation_type.dart';
import 'package:capstone_fa23_driver/core/enums/transaction_status.dart';
import 'package:capstone_fa23_driver/core/models/order_model.dart';
import 'package:capstone_fa23_driver/core/models/traffic_model.dart';
import 'package:capstone_fa23_driver/helpers/api_helper.dart';
import 'package:capstone_fa23_driver/helpers/datetime_helper.dart';
import 'package:capstone_fa23_driver/helpers/location_helper.dart';
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
    var listStatus = [
      TransactionStatus.created,
      TransactionStatus.processing,
      TransactionStatus.pickOff,
      TransactionStatus.shipping
    ];
    var url = "/orders?Limit=$size&Page=$page";
    for (var s in listStatus) {
      url += "&Status=${s.index}";
    }
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
        int p = 1;
        while (_orders.isEmpty && p < response.result["totalPage"]) {
          await getListOrders(page: p + 1);
          p++;
        }
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
    var listStatus = [
      TransactionStatus.deliveryFailed,
      TransactionStatus.delivered,
      TransactionStatus.deleted
    ];
    for (var s in listStatus) {
      url += "&Status=${s.index}";
    }
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
      var order = Order.fromJsonDetail(response.result);
      _order = order;
      return order;
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

  Future<void> cancelOrder(List<String> reasons) async {
    var description = reasons.isNotEmpty
        ? reasons.join(", ")
        : TransactionStatus.deliveryFailed.label;
    final response = await ApiClient().put("/orders/${_order.id}/status", {
      "status": TransactionStatus.deliveryFailed.index,
      "description": description
    });
    if (response.statusCode == HttpStatus.noContent ||
        response.statusCode == HttpStatus.ok) {
      getListOrders();
      getHistory();
      notifyListeners();
    } else {
      throw Exception("Failed to cancel order ${_order.id}");
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

  Future<TrafficModel> traffic(LatLng orderLocation) async {
    var currentLocation = await LocationHelper().getCurrentLocation();
    var data = json.encode([
      {
        "address": "Vị trí hiện tại",
        "lat": currentLocation.latitude,
        "lng": currentLocation.longitude
      },
      {
        "address": "Vị trí đơn hàng ${_order.id}",
        "lat": orderLocation.latitude,
        "lng": orderLocation.longitude
      }
    ]);
    var response = await ApiClient().postRaw("/traffics", data);
    if (response.statusCode == HttpStatus.ok) {
      var responseData = json.decode(response.body);
      _order.distanceFromYou = responseData.first["distance"]["value"];
      _order.durationFromYou = responseData.first["duration"]["value"];
      return TrafficModel(
        distance: responseData.first["distance"]["value"],
        distanceUnit: responseData.first["distance"]["unit"],
        duration: responseData.first["duration"]["value"],
        durationUnit: responseData.first["duration"]["unit"],
      );
    } else {
      throw Exception("Tính khoảng cách thất bại");
    }
  }

  Order? getNextOrder() {
    var index = _orders.indexOf(_order);
    if (index < _orders.length - 1) {
      _order = _orders[index + 1];
      return _order;
    } else {
      return null;
    }
  }
}
