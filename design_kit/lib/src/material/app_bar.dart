import 'package:flutter/material.dart';

class DAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const DAppBar({Key? key, required this.title}) : super(key: key);

  @override
  State<DAppBar> createState() => _DAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 67);
}

class _DAppBarState extends State<DAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
