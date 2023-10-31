import 'package:capstone_fa23_driver/modals/login_phone_number.dart';
import 'package:capstone_fa23_driver/modals/login_username_password.dart';
import 'package:capstone_fa23_driver/modals/register_username_password.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              height: 322,
              width: 311,
              child: Image.asset(
                'assets/images/contexts/context_1.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Container(
            height: 305,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: DColors.gray5,
                    blurRadius: 20,
                  )
                ]),
            child: Column(children: [
              const DSwipeIndicator(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DPrimaryButton.bigwide(
                      text: "Đăng nhập với SĐT",
                      onPressed: () {
                        const LoginPhoneNumberModal().showModal(context)();
                      },
                    ),
                    Text("Hoặc", style: Theme.of(context).textTheme.bodyMedium),
                    DPrimaryButton.bigwide(
                      text: "Đăng nhập với Username",
                      backgroundColor: DColors.orange,
                      onPressed: () {
                        const LoginUsernamePasswordModal().showModal(context)();
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Bạn chưa có tài khoản? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: "Tạo mới",
                            style: const TextStyle(color: DColors.softBlue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                const RegisterUsernamePasswordModal()
                                    .showModal(context)();
                              },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
