import 'package:capstone_fa23_customer/core/enums/error_code.dart';
import 'package:capstone_fa23_customer/providers/account_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginUsernamePasswordModal extends StatefulWidget {
  const LoginUsernamePasswordModal({Key? key}) : super(key: key);

  @override
  State<LoginUsernamePasswordModal> createState() =>
      _LoginPhoneNumberModalState();

  Function showModal(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const LoginUsernamePasswordModal(),
      );
    };
  }
}

class _LoginPhoneNumberModalState extends State<LoginUsernamePasswordModal> {
  final TextEditingController _inputUsernameController =
      TextEditingController();
  final TextEditingController _inputPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isShowPassword = false;
  String? _errorMessage;

  void toggleShowPassword() {
    setState(() {
      _isShowPassword = !_isShowPassword;
    });
  }

  void login(BuildContext context, String username, String password) async {
    setState(() {
      _errorMessage = null;
    });
    var response =
        await context.read<AccountProvider>().loginUsername(username, password);
    if (response.errorCode == ErrorCode.usernameNotExist.code) {
      setState(() {
        _errorMessage = ErrorCode.usernameNotExist.message;
      });
      return;
    }
    if (response.errorCode == ErrorCode.passwordNotCorrect.code) {
      setState(() {
        _errorMessage = ErrorCode.passwordNotCorrect.message;
      });
      return;
    }
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 697,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const DSwipeIndicator(),
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Nhập username & mật khẩu',
                      style: Theme.of(context).textTheme.headlineLarge?.apply(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ),
                  Text(
                    'Sử dụng username và mật khẩu để đăng nhập hoặc đăng kí vào Customer App',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  DTextFormField(
                    hintText: "Vui lòng nhập username",
                    controller: _inputUsernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DTextFormField(
                    hintText: "Vui lòng nhập mật khẩu",
                    controller: _inputPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      return null;
                    },
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
                  if (_errorMessage != null)
                    Text(
                      _errorMessage!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.apply(color: DColors.red),
                    ),
                  const SizedBox(height: 16),
                  DPrimaryButton.bigwide(
                      text: "Tiếp tục",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login(
                            context,
                            _inputUsernameController.text,
                            _inputPasswordController.text,
                          );
                        }
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
