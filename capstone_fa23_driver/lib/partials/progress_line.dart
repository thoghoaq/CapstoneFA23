import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class ProgressLine extends StatelessWidget {
  final double percent;
  const ProgressLine({
    super.key,
    this.percent = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 7,
          width: double.infinity,
          decoration: const BoxDecoration(color: DColors.gray5),
        ),
        FractionallySizedBox(
          widthFactor: percent,
          child: Container(
            height: 7,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                )),
          ),
        ),
      ],
    );
  }
}
