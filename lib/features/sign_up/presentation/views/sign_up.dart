import 'package:flutter/material.dart';
import 'widgets/sign_up_body.dart';


class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SignUpBody(),
    );
  }
}
