import 'package:eye/features/sign_in/presentation/views/widgets/email_box.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/forget_password.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/password_box.dart';
import 'package:eye/features/sign_up/presentation/views/widgets/name_box.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/main_box.dart';

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

        SizedBox(height: 30,),

        NameBox(text: 'Username'),
        SizedBox(height: 5,),
        NameBox(text: 'First Name'),
        SizedBox(height: 5,),
        NameBox(text: 'Last Name'),
        SizedBox(height: 5,),
        EmailBox(text: 'Email'),
        SizedBox(height: 5,),
        PasswordBox(text: 'Password'),
        SizedBox(height: 5,),
        SizedBox(width: 260,
          child: ForgetPassword()),
        SizedBox(
          height: 30,
        ),
        MainBox(
          text: 'التسجيل',
          assetName: AssetsData.arrowIconInternal,
          numWidHig: 30,
          numRight: 22,
          numTop: 16,
        ),
      ]),
    );
  }
}
