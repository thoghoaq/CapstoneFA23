import 'package:flutter/material.dart';

class DUploadImage extends StatelessWidget {
  final String hint;
  final String? label;
  final VoidCallback? onTap;
  const DUploadImage({super.key, required this.hint, this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(label ?? "",
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 336,
            height: 118,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  hint,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
