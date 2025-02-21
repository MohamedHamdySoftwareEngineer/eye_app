import 'package:eye/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'نسيت كلمة مرورك؟',
      style: Styles.brownText18.copyWith(shadows: [], fontSize: 10),
      textAlign: TextAlign.right,
    );
  }
}
