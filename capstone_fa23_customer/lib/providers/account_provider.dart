import 'dart:io';

import 'package:capstone_fa23_customer/core/enums/role.dart';
import 'package:capstone_fa23_customer/core/models/account_model.dart';
import 'package:capstone_fa23_customer/core/models/api_response_model.dart';
import 'package:capstone_fa23_customer/helpers/api_helper.dart';
import 'package:capstone_fa23_customer/helpers/jwt_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountProvider extends ChangeNotifier {
  late Profile _profile;
  int? _id;
  String? _phoneNumber;
  String? _username;
  Role? _role;
  bool _isLoading = true;

  Profile get profile => _profile;
  int? get id => _id;
  String? get phoneNumber => _phoneNumber;
  String? get username => _username;
  Role? get role => _role;
  bool get isLoading => _isLoading;

  Future<void> fetchAccountInformation() async {
    _id ??= await JWTHelper().getId();
    final response = await ApiClient().get("/account-profile/$_id");
    if (response.statusCode == HttpStatus.ok) {
      _phoneNumber = response.result["phoneNumber"];
      _username = response.result["username"];
      _profile = Profile.fromJson(response.result["accountProfile"]);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<ApiResponse> loginUsername(String username, String password) async {
    final response = await ApiClient().post(
      "/auth/login/username",
      {
        "username": username,
        "password": password,
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      await JWTHelper().store(response.result["jwtToken"]);
      if (!await checkLoggedIn()) {
        throw Exception("Access denied");
      }
      _role = Role.customer;
      _id = await JWTHelper().getId();
    }
    return response;
  }

  Future<bool> checkLoggedIn() async {
    try {
      var tokenStr = await JWTHelper().getTokenString();
      var role = await JWTHelper().getRole();
      if (role != Role.customer.code && tokenStr == null) {
        return false;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}