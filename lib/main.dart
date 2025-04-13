import 'package:eye/core/utils/app_router.dart';
import 'package:flutter/material.dart';

void main() {
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
        brightness: Brightness.light,
        fontFamily: 'Cairo', // Use your manually registered Cairo font
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: Colors.white,
            ),
      ),
      themeMode: ThemeMode.light,
    );
  }
}
