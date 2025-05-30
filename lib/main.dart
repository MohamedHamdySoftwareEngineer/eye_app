import 'dart:io';

import 'package:eye/core/utils/app_router.dart';
import 'package:eye/core/utils/constants.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_transation.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (_, __, ___) => true;
    return client;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const EyeApp());
}

class EyeApp extends StatelessWidget {
  const EyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        pageTransitionsTheme:  const PageTransitionsTheme(
          // Disable animations on Android & iOS
          builders: {
            TargetPlatform.android:  FadeTransitionsBuilder(),
            TargetPlatform.iOS:  FadeTransitionsBuilder(),
          },
        ),
        brightness: Brightness.light,
        fontFamily: 'Cairo', 
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: Colors.white,
              fontFamily: 'Cairo',
            ),
      ),
      themeMode: ThemeMode.light,
    );
  }
}
