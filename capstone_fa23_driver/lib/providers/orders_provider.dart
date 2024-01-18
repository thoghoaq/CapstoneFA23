// ignore_for_file: unused_import

import 'dart:async';
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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];
  List<Order> _history = [];
  List<Order> _waitingOrders = [];
  late Order _order;
  bool _isLoading = true;
  String _sort = "-";

  List<Order> get orders => _orders;
  List<Order> get history => _history;
  List<Order> get waitingOrder => _waitingOrders;
  Order get order => _order;
  bool get isLoading => _isLoading;
  String get sort => _sort;

  void clear() {
    _isLoading = true;
    _orders = [];
    _history = [];
    _waitingOrders = [];
  }

  Future<void> getListOrders(
      {TransactionStatus? status, int size = 10, int page = 1}) async {
    var listStatus = [TransactionStatus.pickOff, TransactionStatus.shipping];
    var expectShipingDate = DateTime.now().toIso8601String();
    var url =
        "/orders?Limit=$size&Page=$page&ExpectedShippingDate=$expectShipingDate";
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
              TransactionStatus.isOngoing(element.currentOrderStatus) &&
              DateTimeHelper.isToday(element.expectedShippingDate))
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
          if (!_orders.any((order) => order.id == orders[i].id)) {
            _orders.add(orders[i]);
          }
        }
      }
      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception("Failed to load orders");
    }
  }

  Future<void> getListWatingOrders(
      {TransactionStatus? status, int size = 10, int page = 1}) async {
    var listStatus = [TransactionStatus.created, TransactionStatus.processing];
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
              TransactionStatus.isProcessing(element.currentOrderStatus) &&
              DateTimeHelper.isToday(element.expectedShippingDate))
          .toList();
      if (page == 1) {
        _waitingOrders = orders;
        int p = 1;
        while (_waitingOrders.isEmpty && p < response.result["totalPage"]) {
          await getListWatingOrders(page: p + 1);
          p++;
        }
      } else {
        for (var i = 0; i < orders.length; i++) {
          if (!_waitingOrders.any((order) => order.id == orders[i].id)) {
            _waitingOrders.add(orders[i]);
          }
        }
      }
      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception("Failed to load orders");
    }
  }

  Future<void> getHistory({
    TransactionStatus? status,
    int size = 10,
    int page = 1,
  }) async {
    var sortStr = "${_sort}ExpectedShippingDate";
    var url = "/orders?Limit=$size&Page=$page&Sort=$sortStr";
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

  Future<void> completeOrder({Order? order}) async {
    var ord = order ?? _order;
    final response = await ApiClient().put("/orders/${ord.id}/status", {
      "status": ord.currentOrderStatus.index + 1,
      "description": "Đã hoàn thành đơn hàng"
    });
    if (response.statusCode == HttpStatus.noContent ||
        response.statusCode == HttpStatus.ok) {
      getListWatingOrders();
      getListOrders();
      getHistory();
      notifyListeners();
    } else {
      throw Exception("Cập nhật trạng thái đơn hàng ${ord.id} thất bại");
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
      getListWatingOrders();
      getListOrders();
      getHistory();
      notifyListeners();
    } else {
      throw Exception("Hủy đơn hàng ${_order.id} thất bại");
    }
  }

  Future<String> calculateRoutes(
      LatLng currentLocation, RouteCalculationType? calculationType) async {
    bool useDuration = calculationType == RouteCalculationType.duration;
    var url =
        "/orders/routes?originLat=${currentLocation.latitude}&originLng=${currentLocation.longitude}&useDuration=$useDuration";
    if (calculationType == RouteCalculationType.random) {
      url =
          "/orders/routes/random?originLat=${currentLocation.latitude}&originLng=${currentLocation.longitude}";
    }
    final response = await ApiClient().getRaw(url);
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

      Fluttertoast.showToast(
        msg:
            "Tính toán lộ trình hoàn tất \n Tổng thời gian: ${DateTimeHelper.convertSecondsToHourMinute(responseData["result"]["totalTimeTravel"])}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
      return DateTimeHelper.convertSecondsToHourMinute(
          responseData["result"]["totalTimeTravel"]);
    } else {
      throw Exception("Tính toán lộ trình thất bại");
    }
  }

  Future<TrafficModel> traffic(LatLng orderLocation) async {
    var currentLocation = await LocationHelper().getCurrentLocation();
    var data = json.encode([
      {
        "address": "Vị trí xuất phát",
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
    var index = _orders.indexWhere((order) => order.id == _order.id);
    if (index < _orders.length - 1) {
      return _orders[index + 1];
    } else {
      return null;
    }
  }

  Future<Order?> getDataOfNextOrder() async {
    var index = _orders.indexWhere((order) => order.id == _order.id);
    if (index < _orders.length - 1) {
      final response =
          await ApiClient().get("/orders/${_orders[index + 1].id}");
      if (response.statusCode == HttpStatus.ok) {
        var order = Order.fromJsonDetail(response.result);
        return order;
      }
    }
    return null;
  }

  void toggleSelectWaitingOrder(String orderId) {
    var ord = _waitingOrders.firstWhere((element) => element.id == orderId);
    if (ord.isWatingOrderSelected == null) {
      ord.isWatingOrderSelected = true;
    } else {
      ord.isWatingOrderSelected = !ord.isWatingOrderSelected!;
    }
    notifyListeners();
  }

  void selectAllWaitingOrders() {
    for (var ord in _waitingOrders) {
      ord.isWatingOrderSelected = true;
    }
    notifyListeners();
  }

  void unSelectAllWaitingOrders() {
    for (var ord in _waitingOrders) {
      ord.isWatingOrderSelected = false;
    }
    notifyListeners();
  }

  Future<void> pickUpWaitingOrders() async {
    var selectedOrders =
        _waitingOrders.where((o) => o.isWatingOrderSelected == true).toList();
    for (var element in selectedOrders) {
      await completeOrder(order: element);
      element.currentOrderStatus =
          TransactionStatus.values[element.currentOrderStatus.index + 1];
    }
    autoChangeStatusOrder(selectedOrders);
  }

  void autoChangeStatusOrder(List<Order> selectedOrder) {
    const Duration delay = Duration(seconds: 30);

    Timer(delay, () async {
      for (var element in selectedOrder) {
        await completeOrder(order: element);
        Fluttertoast.showToast(
          msg: "Cập nhật trạng thái đơn hàng ${element.id}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
        );
      }
    });
  }

  Future sortOrders() async {
    if (_sort == "+") {
      await getHistory();
      _sort = "-";
    } else {
      await getHistory();
      _sort = "+";
    }
  }
}
