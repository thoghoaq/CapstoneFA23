import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class DActiveNavigationBarIcon extends StatelessWidget {
  final Widget icon;
  const DActiveNavigationBarIcon({Key? key, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: DColors.softGreen,
          ),
          child: Column(
            children: [
              Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
          width: 20,
          height: 20,
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary, BlendMode.srcIn),
              child: icon),
        )
      ],
    );
  }
}
