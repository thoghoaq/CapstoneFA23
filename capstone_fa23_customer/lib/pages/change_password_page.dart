import 'dart:io';

import 'package:capstone_fa23_customer/providers/account_provider.dart';
import 'package:capstone_fa23_customer/providers/orders_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _inputPasswordController =
      TextEditingController();
  bool _isShowPassword = false;
  void toggleShowPassword() {
    setState(() {
      _isShowPassword = !_isShowPassword;
    });
  }

  final TextEditingController _inputOldPasswordController =
      TextEditingController();
  bool _isShowOldPassword = false;
  void toggleShowOldPassword() {
    setState(() {
      _isShowOldPassword = !_isShowOldPassword;
    });
  }

  final TextEditingController _inputConfirmPasswordController =
      TextEditingController();
  bool _isShowConfirmPassword = false;
  void toggleShowConfirmPassword() {
    setState(() {
      _isShowConfirmPassword = !_isShowConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(title: "Đổi mật khẩu"),
      body: Column(children: [
        const SizedBox(width: double.infinity),
        DTextBox(
          hintText: "Vui lòng nhập mật khẩu cũ",
          controller: _inputOldPasswordController,
          suffixIcon: GestureDetector(
            onTap: () => toggleShowOldPassword(),
            child: Icon(
                !_isShowOldPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Theme.of(context).colorScheme.primary),
          ),
          obscureText: !_isShowOldPassword,
        ),
        const SizedBox(height: 16),
        DTextBox(
          hintText: "Vui lòng nhập mật khẩu mới",
          controller: _inputPasswordController,
          suffixIcon: GestureDetector(
            onTap: () => toggleShowPassword(),
            child: Icon(
                !_isShowPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Theme.of(context).colorScheme.primary),
          ),
          obscureText: !_isShowPassword,
        ),
        const SizedBox(height: 16),
        DTextBox(
          hintText: "Vui lòng nhập lại mật khẩu mới",
          controller: _inputConfirmPasswordController,
          suffixIcon: GestureDetector(
            onTap: () => toggleShowConfirmPassword(),
            child: Icon(
                !_isShowConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Theme.of(context).colorScheme.primary),
          ),
          obscureText: !_isShowConfirmPassword,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: DPrimaryButton(
                text: "Tiếp tục",
                onPressed: () async {
                  try {
                    var provider = context.read<AccountProvider>();
                    var response = await provider.changePassword(
                        _inputOldPasswordController.text,
                        _inputPasswordController.text,
                        _inputConfirmPasswordController.text);
                    if (response.statusCode == HttpStatus.noContent) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      if (context.mounted) {
                        context.read<AccountProvider>().clear();
                        context.read<OrderProvider>().clear();
                        context.go('/login');
                        Fluttertoast.showToast(
                            msg: "Đổi mật khẩu thành công",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: response.errorMessage.toString(),
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER);
                    }
                  } on Exception catch (e) {
                    Fluttertoast.showToast(
                        msg: e.toString(),
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER);
                  }
                },
              ),
            ),
          ),
        )
      ]),
    );
  }
}
