import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final Text title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showTopDivider;
  final bool showBottomDivider;

  const ProfileListTile({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onTap,
    this.showBottomDivider = true,
    this.showTopDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: showBottomDivider
              ? const BorderSide(color: DColors.gray6)
              : BorderSide.none,
          top: showTopDivider
              ? const BorderSide(color: DColors.gray6)
              : BorderSide.none,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: leading,
        title: title,
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
