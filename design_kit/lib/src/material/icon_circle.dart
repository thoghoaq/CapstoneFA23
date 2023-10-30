import 'package:design_kit/src/material/colors.dart';
import 'package:flutter/material.dart';

class DIconCircle extends StatelessWidget {
  final Icon icon;
  const DIconCircle({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
          color: DColors.defaultText, borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: ColorFiltered(
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.background, BlendMode.srcIn),
            child: icon),
      ),
    );
  }
}
