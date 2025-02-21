import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(
          'التسجيل في المنصة',
          style: Styles.brownText18,
        ),
      ]),
    );
  }
}
