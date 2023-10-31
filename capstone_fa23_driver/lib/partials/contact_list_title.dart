import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
  final Widget? avatar;
  final String title;
  final String? subtitle;
  const ContactListTile(
      {super.key, this.avatar, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (avatar != null)
            DAvatarCircle(
              image: avatar!,
              radius: 40,
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(subtitle ?? "",
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
          const Row(
            children: [
              DIconCircle(
                  icon: Icon(
                Icons.phone,
                size: 16,
              )),
              SizedBox(width: 16),
              DIconCircle(
                  icon: Icon(
                Icons.messenger,
                size: 16,
              )),
            ],
          )
        ],
      ),
    );
  }
}
