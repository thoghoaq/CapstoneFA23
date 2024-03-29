import 'dart:io';

import 'package:capstone_fa23_customer/core/enums/role.dart';
import 'package:capstone_fa23_customer/core/models/account_model.dart';
import 'package:capstone_fa23_customer/core/models/api_response_model.dart';
import 'package:capstone_fa23_customer/helpers/api_helper.dart';
import 'package:capstone_fa23_customer/helpers/jwt_helper.dart';
import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  Profile _profile = Profile();
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

  void clear() {
    _id = null;
    _phoneNumber = null;
    _username = null;
    _role = null;
    _isLoading = true;
  }

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

  Future<ApiResponse> register(String username, String password) async {
    final response = await ApiClient().post(
      "/auth/register/username",
      {
        "username": username,
        "role": Role.customer.index,
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

  Future<ApiResponse> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    try {
      final response = await ApiClient().put(
        "/auth/username/changePassword",
        {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> updateProfile(String name, DateTime birthDay, String province,
      String district, String ward, String address, String phoneContact) async {
    var data = {
      "name": name,
      "birthDay": birthDay.toIso8601String(),
      "province": province,
      "district": district,
      "ward": ward,
      "address": address,
      "phoneContact": phoneContact,
    };
    _id = await JWTHelper().getId();
    final response = await ApiClient().put(
      "/account-profile/$_id",
      data,
    );
    if (response.statusCode == HttpStatus.noContent) {
      _profile = Profile.fromJson(data);
      notifyListeners();
      return true;
    }
    return false;
  }
}
