import 'package:flutter/material.dart';

import 'features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const EyeApp());
}

class EyeApp extends StatelessWidget {
  const EyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
     
    );
  }
}
