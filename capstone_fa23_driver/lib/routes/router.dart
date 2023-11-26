import 'package:capstone_fa23_driver/pages/change_password_page.dart';
import 'package:capstone_fa23_driver/pages/login_page.dart';
import 'package:capstone_fa23_driver/pages/logo_page.dart';
import 'package:capstone_fa23_driver/pages/main_page.dart';
import 'package:capstone_fa23_driver/pages/map_view_page.dart';
import 'package:capstone_fa23_driver/pages/profile_page.dart';
import 'package:capstone_fa23_driver/pages/orders_page.dart';
import 'package:capstone_fa23_driver/pages/update_profile_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        name: 'logoScreen',
        builder: (context, state) => const LogoScreenPage(),
        path: '/',
        routes: [
          GoRoute(
            name: 'loginScreen',
            builder: (context, state) => const LoginScreenPage(),
            path: 'login',
          ),
          ShellRoute(
            builder: (context, state, child) => MainPage(child: child),
            routes: [
              // GoRoute(
              //   name: "home",
              //   path: "home",
              //   builder: (context, state) => const HomePage(),
              // ),
              GoRoute(
                name: "orders",
                path: "orders",
                builder: (context, state) => OrdersPage(),
                routes: [
                  GoRoute(
                    name: "mapView",
                    path: "map-view",
                    builder: (context, state) => const MapViewPage(),
                  ),
                ],
              ),
              GoRoute(
                name: "profile",
                path: "profile",
                builder: (context, state) => const ProfilePage(),
                routes: [
                  GoRoute(
                    name: "updateProfile",
                    path: "update",
                    builder: (context, state) => UpdateProfilePage(),
                  ),
                  GoRoute(
                    name: "changePassword",
                    path: "change-password",
                    builder: (context, state) => const ChangePasswordPage(),
                  ),
                ],
              ),
            ],
          )
        ]),
  ],
);
