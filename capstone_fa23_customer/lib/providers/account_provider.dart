import 'package:capstone_fa23_customer/core/models/account_model.dart';
import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  late Account _account;
  bool _isLoading = true;

  Account get account => _account;
  bool get isLoading => _isLoading;

  Future<void> fetchAccountInformation() async {
    // final response = await http.get(Uri.parse("$apiUrl/account"));

    // if (response.statusCode == 200) {
    //   final Map<String, dynamic> data = json.decode(response.body);
    //   _account = Account.fromJson(data);
    //   notifyListeners();
    // } else {
    //   throw Exception('Failed to load account information');
    // }
    await Future.delayed(const Duration(seconds: 5));
    _account = Account.mock();
    _isLoading = false;
    notifyListeners();
  }
}
