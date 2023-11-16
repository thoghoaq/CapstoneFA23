import 'package:capstone_fa23_customer/pages/change_password_page.dart';
import 'package:capstone_fa23_customer/pages/login_page.dart';
import 'package:capstone_fa23_customer/pages/logo_page.dart';
import 'package:capstone_fa23_customer/pages/main_page.dart';
import 'package:capstone_fa23_customer/pages/profile_page.dart';
import 'package:capstone_fa23_customer/pages/tracking_order.dart';
import 'package:capstone_fa23_customer/pages/transaction_page.dart';
import 'package:capstone_fa23_customer/pages/update_profile_page.dart';
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
                name: "home",
                path: "home",
                builder: (context, state) => const TransactionPage(),
                routes: [
                  GoRoute(
                    name: "trackingOrder",
                    path: "tracking-order/:id",
                    builder: (context, state) =>
                        TrackingOrderPage(id: state.pathParameters['id']!),
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
                    builder: (context, state) => const UpdateProfilePage(),
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
