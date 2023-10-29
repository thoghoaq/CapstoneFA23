import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

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
                DTextBox(
                  hintText: "Vui lòng nhập username",
                  controller: _inputUsernameController,
                ),
                const SizedBox(height: 16),
                DTextBox(
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
                ),
                const SizedBox(height: 16),
                DTextBox(
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
                ),
                const SizedBox(height: 32),
                DPrimaryButton.bigwide(text: "Tiếp tục", onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}
