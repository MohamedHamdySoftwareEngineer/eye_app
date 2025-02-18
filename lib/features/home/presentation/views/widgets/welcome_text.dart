import 'package:eye/core/utils/styles.dart';
import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(30),
      child: Text('!نورت منصة عين', style: Styles.myWelcomeText18),
    );
  }
}
