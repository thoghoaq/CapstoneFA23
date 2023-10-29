import 'package:capstone_fa23_customer/pages/home_page.dart';
import 'package:capstone_fa23_customer/pages/login_page.dart';
import 'package:capstone_fa23_customer/pages/logo_page.dart';
import 'package:capstone_fa23_customer/pages/main_page.dart';
import 'package:capstone_fa23_customer/pages/profile_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      name: 'logoScreen',
      builder: (context, state) => const LogoScreenPage(),
      path: '/',
    ),
    GoRoute(
      name: 'loginScreen',
      builder: (context, state) => const LoginScreenPage(),
      path: '/login',
    ),
    ShellRoute(
      builder: (context, state, child) => MainPage(child: child),
      routes: [
        GoRoute(
          name: "home",
          path: "/home",
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: "profile",
          path: "/profile",
          builder: (context, state) => const ProfilePage(),
        )
      ],
    )
  ],
);
