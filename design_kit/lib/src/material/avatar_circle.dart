import 'package:flutter/material.dart';

class DAvatarCircle extends StatelessWidget {
  final Widget image;
  final double radius;

  const DAvatarCircle({
    Key? key,
    required this.image,
    this.radius = 28.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: ClipOval(
        child: FittedBox(
          fit: BoxFit.cover,
          child: image,
        ),
      ),
    );
  }
}
