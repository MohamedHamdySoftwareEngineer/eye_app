import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/widgets/main_box.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/email_box.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/forget_password.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/password_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/styles.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          '! تسجيل الدخول',
          style: Styles.brownText18,
        ),
        const SizedBox(
          height: 30,
        ),
        const EmailBox(text: 'Email or Username'),
        const SizedBox(
          height: 5,
        ),
        const PasswordBox(text: 'Password'),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 260,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.rSignUp);
                },
                child: Text(
                  'إضافة حساب؟',
                  style: Styles.brownText18.copyWith(shadows: [], fontSize: 10),
                ),
              ),
              const ForgetPassword(),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const MainBox(
          text: 'تسجيل الدخول',
          assetName: AssetsData.arrowIconInternal,
          numWidHig: 30,
          numRight: 22,
          numTop: 16,
        ),
      ]),
    );
  }
}
