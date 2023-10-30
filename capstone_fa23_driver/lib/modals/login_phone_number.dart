import 'package:capstone_fa23_driver/partials/input_otp.dart';
import 'package:capstone_fa23_driver/partials/input_phone_number.dart';
import 'package:capstone_fa23_driver/partials/input_username.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class LoginPhoneNumberModal extends StatefulWidget {
  const LoginPhoneNumberModal({Key? key}) : super(key: key);

  @override
  State<LoginPhoneNumberModal> createState() => _LoginPhoneNumberModalState();

  Function showModal(BuildContext context) {
    return () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => const LoginPhoneNumberModal(),
      );
    };
  }
}

class _LoginPhoneNumberModalState extends State<LoginPhoneNumberModal> {
  final TextEditingController _inputPhoneController = TextEditingController();
  final TextEditingController _inputUsernameController =
      TextEditingController();
  bool _isShowInputOTP = false;
  bool _isShowInputUserName = false;

  void _showInputOTP() {
    setState(() {
      _isShowInputOTP = true;
    });
  }

  void _showInputUserName() {
    setState(() {
      _isShowInputUserName = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 627,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const DSwipeIndicator(),
          !_isShowInputOTP
              ? InputPhoneNumber(
                  controller: _inputPhoneController,
                  callback: _showInputOTP,
                )
              : !_isShowInputUserName
                  ? InputOTP(
                      callback: _showInputUserName,
                    )
                  : InputUsername(controller: _inputUsernameController)
        ],
      ),
    );
  }
}
