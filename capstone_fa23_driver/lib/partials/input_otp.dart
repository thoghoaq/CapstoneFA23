import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class InputOTP extends StatelessWidget {
  final VoidCallback? callback;
  const InputOTP({
    Key? key,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Nhập mã xác thực OTP',
              style: Theme.of(context).textTheme.headlineLarge?.apply(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          Text(
            'Một mã xác thực đã được gửi tới +84 8297127712',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const DOTPInput(),
          const SizedBox(height: 32),
          DPrimaryButton.bigwide(text: "Tiếp tục", onPressed: callback),
        ],
      ),
    );
  }
}
