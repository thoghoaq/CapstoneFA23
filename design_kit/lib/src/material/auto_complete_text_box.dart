import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DAutoCompleteTextBox extends StatelessWidget {
  const DAutoCompleteTextBox({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.label,
    this.maxLines,
    required this.provinceTextController,
    required this.suggestionsCallback,
    required this.itemBuilder,
    required this.onSuggestionSelected,
  }) : super(key: key);

  final TextEditingController provinceTextController;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? label;
  final int? maxLines;
  final FutureOr<Iterable<Object?>> Function(String pattern)
      suggestionsCallback;
  final Widget Function(BuildContext context, Object? item) itemBuilder;
  final void Function(Object? suggestion) onSuggestionSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 336,
      height: label != null ? 90 : 60,
      child: Column(
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
          TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: provinceTextController,
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
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 28,
                  minHeight: 28,
                ),
              ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            suggestionsCallback: suggestionsCallback,
            itemBuilder: itemBuilder,
            onSuggestionSelected: onSuggestionSelected,
          ),
        ],
      ),
    );
  }
}
