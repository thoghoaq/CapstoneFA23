import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class DOTPInput extends StatelessWidget {
  const DOTPInput({super.key});

  final _otpLength = 6;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: _otpLength,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      // validator: (s) {
      //   if (s!.length < _otpLength) {
      //     return 'Mã OTP phải có 6 chữ số';
      //   }
      //   return null;
      // },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      // ignore: avoid_print
      onCompleted: (pin) => print(pin),
    );
  }
}

final defaultPinTheme = PinTheme(
  width: 50,
  height: 50,
  textStyle: const TextStyle(fontSize: 24, color: DColors.defaultText),
  decoration: BoxDecoration(
      border: Border.all(color: DColors.gray5),
      borderRadius: BorderRadius.circular(4),
      color: DColors.gray6),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: DColors.primary),
  borderRadius: BorderRadius.circular(4),
);

final submittedPinTheme = focusedPinTheme;
