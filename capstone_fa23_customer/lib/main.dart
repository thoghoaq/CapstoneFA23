import 'dart:ui';

import 'package:capstone_fa23_customer/providers/index.dart';
import 'package:capstone_fa23_customer/routes/router.dart';
import 'package:capstone_fa23_customer/themes/color_scheme.dart';
import 'package:capstone_fa23_customer/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    Fluttertoast.showToast(
      msg: "Có lỗi xảy ra",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FlutterError.presentError(
        FlutterErrorDetails(exception: error, stack: stack));
    Fluttertoast.showToast(
      msg: "Có lỗi xảy ra",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp.router(
        title: 'CustomerApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: colorScheme,
          textTheme: textTheme,
          useMaterial3: true,
        ),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        ),
        routerConfig: router,
      ),
    );
  }
}
