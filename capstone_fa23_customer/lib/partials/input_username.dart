import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InputUsername extends StatelessWidget {
  const InputUsername({
    super.key,
    required TextEditingController controller,
  }) : _inputUsernameController = controller;

  final TextEditingController _inputUsernameController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Nhập username',
              style: Theme.of(context).textTheme.headlineLarge?.apply(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          Text(
            'Nhập username của bạn ở đây',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          DTextBox(
            hintText: "Vui lòng nhập username",
            controller: _inputUsernameController,
          ),
          const SizedBox(height: 32),
          DPrimaryButton.bigwide(
              text: "Tiếp tục",
              onPressed: () {
                context.go('/home');
              }),
        ],
      ),
    );
  }
}
