import 'package:capstone_fa23_driver/pages/change_password_page.dart';
import 'package:capstone_fa23_driver/pages/login_page.dart';
import 'package:capstone_fa23_driver/pages/logo_page.dart';
import 'package:capstone_fa23_driver/pages/main_page.dart';
import 'package:capstone_fa23_driver/pages/map_view_page.dart';
import 'package:capstone_fa23_driver/pages/profile_page.dart';
import 'package:capstone_fa23_driver/pages/orders_page.dart';
import 'package:capstone_fa23_driver/pages/qr_scanner_page.dart';
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
              GoRoute(
                name: "orders",
                path: "orders",
                builder: (context, state) => const OrdersPage(),
                routes: [
                  GoRoute(
                    name: "mapView",
                    path: "map-view/:id",
                    builder: (context, state) =>
                        MapViewPage(id: state.pathParameters['id']!),
                  ),
                ],
              ),
              GoRoute(
                name: "scanner",
                path: "scanner",
                builder: (context, state) => const QRCodeScannerScreen(),
              ),
              GoRoute(
                name: "profile",
                path: "profile",
                builder: (context, state) => const ProfilePage(),
                routes: [
                  GoRoute(
                    name: "updateProfile",
                    path: "update/:firstLogin",
                    builder: (context, state) => UpdateProfilePage(
                        firstLogin:
                            state.pathParameters['firstLogin'] == 'true'),
                  ),
                  GoRoute(
                    name: "changePassword",
                    path: "change-password",
                    builder: (context, state) => const ChangePasswordPage(),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            name: "updateProfileFirstLogin",
            path: "updateFirstLogin/:firstLogin",
            builder: (context, state) => UpdateProfilePage(
                firstLogin: state.pathParameters['firstLogin'] == 'true'),
          ),
        ]),
  ],
);
