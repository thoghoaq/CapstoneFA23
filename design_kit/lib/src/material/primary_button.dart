library design_kit;

import 'package:flutter/material.dart';

class DPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;

  const DPrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
  }) : super(key: key);

  factory DPrimaryButton.big({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? backgroundColor,
  }) {
    return DPrimaryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      width: 333,
      height: 59,
    );
  }

  factory DPrimaryButton.bigwide({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? backgroundColor,
  }) {
    return DPrimaryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      width: 325,
      height: 50,
    );
  }

  factory DPrimaryButton.medium({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? backgroundColor,
  }) {
    return DPrimaryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      width: 295,
      height: 54,
    );
  }

  factory DPrimaryButton.xmedium({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? backgroundColor,
  }) {
    return DPrimaryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      width: 182,
      height: 40,
    );
  }

  factory DPrimaryButton.small({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? backgroundColor,
  }) {
    return DPrimaryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      width: 166,
      height: 40,
    );
  }

  factory DPrimaryButton.xsmall({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? backgroundColor,
  }) {
    return DPrimaryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      width: 136,
      height: 38,
    );
  }

  factory DPrimaryButton.xxsmall({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    double? width,
    double? height,
    Color? backgroundColor,
  }) {
    return DPrimaryButton(
      key: key,
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      width: 100,
      height: 33,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                backgroundColor ?? Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            minimumSize: Size(width ?? 295, height ?? 54),
          ),
          child: Text(
            text,
            style: TextStyle(color: Theme.of(context).colorScheme.background),
          )),
    );
  }
}
