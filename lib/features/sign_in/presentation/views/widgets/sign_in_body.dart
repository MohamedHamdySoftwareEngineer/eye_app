import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/styles.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '!تسجيل الدخول',
          style: Styles.brownText18,
        ),
        SizedBox(height: 30,),
        EmailBox(),
      ]),
    );
  }
}

class EmailBox extends StatelessWidget {
  const EmailBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      width: 260,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
        
      ),
      child: const Text(
        'Email or Username',
        style: Styles.signTextStyle,
      ),
    );
  }
}
