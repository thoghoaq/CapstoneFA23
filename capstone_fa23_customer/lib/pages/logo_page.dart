import 'package:capstone_fa23_customer/providers/account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LogoScreenPage extends StatelessWidget {
  const LogoScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      isLogged() async {
        if (await context.read<AccountProvider>().checkLoggedIn()) {
          if (context.mounted) {
            context.go('/home');
          }
        } else {
          if (context.mounted) {
            context.go('/login');
          }
        }
      }

      isLogged();
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: GestureDetector(
        onTap: () {
          context.go('/login');
        },
        child: Center(
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
      ),
    );
  }
}
