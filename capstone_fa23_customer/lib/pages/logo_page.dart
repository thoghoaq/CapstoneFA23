import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoScreenPage extends StatelessWidget {
  const LogoScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logos/app_logo.svg',
              width: 149,
              height: 133,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Customer App',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
