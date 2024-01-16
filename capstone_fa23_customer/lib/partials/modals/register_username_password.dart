import 'package:capstone_fa23_customer/providers/account_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterUsernamePasswordModal extends StatefulWidget {
  const RegisterUsernamePasswordModal({Key? key}) : super(key: key);

  @override
  State<RegisterUsernamePasswordModal> createState() =>
      _LoginPhoneNumberModalState();

  Function showModal(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const RegisterUsernamePasswordModal(),
      );
    };
  }
}

class _LoginPhoneNumberModalState extends State<RegisterUsernamePasswordModal> {
  final TextEditingController _inputUsernameController =
      TextEditingController();
  final TextEditingController _inputPasswordController =
      TextEditingController();
  final TextEditingController _inputConfirmPasswordController =
      TextEditingController();
  bool _isShowPassword = false;
  bool _isShowConfirmPassword = false;
  final _formKey = GlobalKey<FormState>();

  void toggleShowPassword() {
    setState(() {
      _isShowPassword = !_isShowPassword;
    });
  }

  void toggleShowConfirmPassword() {
    setState(() {
      _isShowConfirmPassword = !_isShowConfirmPassword;
    });
  }

  void register(BuildContext context, String username, String password) async {
    try {
      await context.read<AccountProvider>().register(username, password);
      if (mounted) {
        context.go('/updateFirstLogin/true');
      }
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      });
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
                      'Đăng ký với username & mật khẩu',
                      textAlign: TextAlign.center,
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
                  SizedBox(
                    width: 336,
                    child: DTextFormField(
                      hintText: "Vui lòng nhập username",
                      controller: _inputUsernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập username';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 336,
                    child: DTextFormField(
                      hintText: "Vui lòng nhập mật khẩu",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (value.length < 8) {
                          return 'Mật khẩu phải có ít nhất 8 ký tự';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 336,
                    child: DTextFormField(
                      hintText: "Vui lòng nhập lại mật khẩu",
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (value != _inputPasswordController.text) {
                          return 'Mật khẩu không khớp';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  DPrimaryButton.bigwide(
                      text: "Tiếp tục",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          register(context, _inputUsernameController.text,
                              _inputConfirmPasswordController.text);
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
