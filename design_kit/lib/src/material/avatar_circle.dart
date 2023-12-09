import 'package:flutter/material.dart';

class DAvatarCircle extends StatelessWidget {
  final Widget image;
  final double radius;
  final VoidCallback? onTap;
  final bool? isLoading;

  const DAvatarCircle({
    Key? key,
    required this.image,
    this.radius = 28.0,
    this.onTap,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ClipOval(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: image,
                ),
              ),
      ),
    );
  }
}
