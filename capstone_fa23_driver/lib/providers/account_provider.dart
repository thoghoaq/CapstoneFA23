import 'dart:convert';
import 'dart:io';

import 'package:capstone_fa23_driver/core/enums/role.dart';
import 'package:capstone_fa23_driver/core/models/account_model.dart';
import 'package:capstone_fa23_driver/core/models/api_response_model.dart';
import 'package:capstone_fa23_driver/helpers/api_helper.dart';
import 'package:capstone_fa23_driver/helpers/jwt_helper.dart';
import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  Profile? _profile;
  int? _id;
  String? _phoneNumber;
  String? _username;
  Role? _role;
  bool _isLoading = true;

  Profile? get profile => _profile;
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
    final response = await ApiClient().get("/account-profile/drivers/$_id");
    if (response.statusCode == HttpStatus.ok) {
      _phoneNumber = response.result["phoneNumber"];
      _username = response.result["username"];
      _profile = Profile.fromJson(response.result["driverProfile"]);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<ApiResponse> loginUsername(String username, String password) async {
    final response = await ApiClient().post(
      "/auth/login/username",
      json.encode({
        "username": username,
        "password": password,
      }),
    );
    if (response.statusCode == HttpStatus.ok) {
      await JWTHelper().store(response.result["jwtToken"]);
      if (!await checkLoggedIn()) {
        throw Exception("Access denied");
      }
      _role = Role.driver;
      _id = await JWTHelper().getId();
    }
    return response;
  }

  Future<ApiResponse> register(String username, String password) async {
    final response = await ApiClient().post(
      "/auth/register/username",
      json.encode({
        "username": username,
        "role": Role.driver.index,
        "password": password,
      }),
    );
    if (response.statusCode == HttpStatus.ok) {
      await JWTHelper().store(response.result["jwtToken"]);
      if (!await checkLoggedIn()) {
        throw Exception("Access denied");
      }
      _role = Role.driver;
      _id = await JWTHelper().getId();
    }
    return response;
  }

  Future<bool> checkLoggedIn() async {
    try {
      var tokenStr = await JWTHelper().getTokenString();
      var role = await JWTHelper().getRole();
      if (role != Role.driver.code && tokenStr == null) {
        return false;
      }
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> updateProfile(
      String name,
      DateTime birthDay,
      String province,
      String district,
      String ward,
      String address,
      String phoneContact,
      String avatarUrl,
      String identificationCardFrontUrl,
      String identificationCardBackUrl,
      String drivingLicenseFrontUrl,
      String drivingLicenseBackUrl,
      String vehicleRegistrationCertificateFrontUrl,
      String vehicleRegistrationCertificateBackUrl) async {
    var data = {
      "name": name,
      "birthDay": birthDay.toIso8601String(),
      "province": province,
      "district": district,
      "ward": ward,
      "address": address,
      "phoneContact": phoneContact,
      "avatarUrl": avatarUrl,
      "identificationCardFrontUrl": identificationCardFrontUrl,
      "identificationCardBackUrl": identificationCardBackUrl,
      "drivingLicenseFrontUrl": drivingLicenseFrontUrl,
      "drivingLicenseBackUrl": drivingLicenseBackUrl,
      "vehicleRegistrationCertificateFrontUrl":
          vehicleRegistrationCertificateFrontUrl,
      "vehicleRegistrationCertificateBackUrl":
          vehicleRegistrationCertificateBackUrl,
    };
    _id = await JWTHelper().getId();
    final response = await ApiClient().put(
      "/account-profile/drivers/$_id",
      data,
    );
    if (response.statusCode == HttpStatus.noContent) {
      _profile = Profile.fromJson(data);
      notifyListeners();
      return true;
    } else {
      throw Exception("Failed to update profile: ${response.errorMessage}");
    }
  }
}
