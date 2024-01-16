import 'dart:ui';

import 'package:capstone_fa23_driver/firebase_options.dart';
import 'package:capstone_fa23_driver/providers/index.dart';
import 'package:capstone_fa23_driver/routes/router.dart';
import 'package:capstone_fa23_driver/themes/color_scheme.dart';
import 'package:capstone_fa23_driver/themes/text_theme.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

void main() async {
  await dotenv.load();
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
  var app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instanceFor(app: app)
      .activate(androidProvider: AndroidProvider.debug);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp.router(
        title: 'Driver App',
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
