library design_kit;

import 'package:flutter/material.dart';

class DTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? label;
  final int? maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const DTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.label,
    this.maxLines,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        TextFormField(
          controller: controller,
          obscureText: obscureText ?? false,
          validator: validator,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: 1,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: prefixIcon,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: suffixIcon,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 28,
              minHeight: 28,
            ),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
