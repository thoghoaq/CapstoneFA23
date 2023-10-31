library design_kit;

import 'package:flutter/material.dart';

class DOutlinedButton extends StatelessWidget {
  final String text;
  final Color? textColor;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? outlinedColor;

  const DOutlinedButton({
    Key? key,
    required this.text,
    this.textColor,
    this.onPressed,
    this.width,
    this.height,
    this.outlinedColor,
  }) : super(key: key);

  factory DOutlinedButton.big({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) {
    return DOutlinedButton(
      key: key,
      text: text,
      onPressed: onPressed,
      width: 333,
      height: 59,
    );
  }

  factory DOutlinedButton.bigwide({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) {
    return DOutlinedButton(
      key: key,
      text: text,
      onPressed: onPressed,
      width: 325,
      height: 50,
    );
  }

  factory DOutlinedButton.medium({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) {
    return DOutlinedButton(
      key: key,
      text: text,
      onPressed: onPressed,
      width: 295,
      height: 54,
    );
  }

  factory DOutlinedButton.xmedium({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) {
    return DOutlinedButton(
      key: key,
      text: text,
      onPressed: onPressed,
      width: 182,
      height: 40,
    );
  }

  factory DOutlinedButton.small({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) {
    return DOutlinedButton(
      key: key,
      text: text,
      onPressed: onPressed,
      width: 166,
      height: 40,
    );
  }

  factory DOutlinedButton.xsmall({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) {
    return DOutlinedButton(
      key: key,
      text: text,
      onPressed: onPressed,
      width: 136,
      height: 38,
    );
  }

  factory DOutlinedButton.xxsmall({
    Key? key,
    required String text,
    VoidCallback? onPressed,
  }) {
    return DOutlinedButton(
      key: key,
      text: text,
      onPressed: onPressed,
      width: 100,
      height: 33,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: BorderSide(
                  color: outlinedColor ?? Theme.of(context).colorScheme.primary,
                  width: 2,
                )),
            minimumSize: Size(width ?? 295, height ?? 54),
          ),
          child: Text(
            text,
            style: TextStyle(
                color: textColor ?? Theme.of(context).colorScheme.primary),
          )),
    );
  }
}
