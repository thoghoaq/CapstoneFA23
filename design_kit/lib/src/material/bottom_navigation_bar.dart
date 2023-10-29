import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class DBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final Function(int)? onTap;

  const DBottomNavigationBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: DColors.gray3,
      backgroundColor: Theme.of(context).colorScheme.background,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      useLegacyColorScheme: true,
    );
  }
}
