import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class DSwipeIndicator extends StatelessWidget {
  const DSwipeIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 77,
          height: 5,
          decoration: BoxDecoration(
            color: DColors.gray5,
            borderRadius: BorderRadius.circular(100),
          )),
    );
  }
}
