import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class InputPhoneNumber extends StatelessWidget {
  const InputPhoneNumber({
    Key? key,
    required this.controller,
    this.callback,
  }) : super(key: key);

  final TextEditingController controller;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Nhập SĐT của bạn',
              style: Theme.of(context).textTheme.headlineLarge?.apply(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          Text(
            'Sử dụng SĐT của bạn để đăng kí hoặc đăng nhập vào Customer App',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          DTextBox(
            hintText: "Vietnam, Vui lòng nhập số điện thoại",
            controller: controller,
            prefixIcon: DAvatarCircle(
              image: Image.asset(
                'assets/images/icons/vietnam.png',
              ),
            ),
          ),
          const SizedBox(height: 32),
          DPrimaryButton.bigwide(text: "Tiếp tục", onPressed: callback),
        ],
      ),
    );
  }
}
