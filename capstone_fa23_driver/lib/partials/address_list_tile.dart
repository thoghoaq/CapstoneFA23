import 'package:flutter/material.dart';

class AddressListTile extends StatelessWidget {
  final Widget? avatar;
  final String title;
  final String address;
  final String? subtitle;
  final Widget? trailing;
  const AddressListTile(
      {super.key,
      this.avatar,
      required this.title,
      required this.address,
      this.subtitle,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (avatar != null) avatar!,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(address,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(subtitle ?? "",
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
          const SizedBox(width: 16),
          if (trailing != null) trailing!
        ],
      ),
    );
  }
}
