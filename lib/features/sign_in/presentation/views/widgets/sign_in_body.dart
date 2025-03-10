import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/widgets/main_box.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/email_box.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/forget_password.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/password_box.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eye/features/sign_in/presentation/manager/features/sign_in/presentation/cubit/sign_in_cubit.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  // Create controllers to capture user input.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        // Using SingleChildScrollView for better handling on smaller devices.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '! تسجيل الدخول',
              style: Styles.brownText18,
            ),
            const SizedBox(
              height: 30,
            ),
            // Pass the controllers to your custom widgets if they support it.
            EmailBox(
              text: 'Email',
              controller: emailController,
            ),
            const SizedBox(
              height: 5,
            ),
            PasswordBox(
              text: 'Password',
              controller: passwordController,
            ),
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
                      style: Styles.brownText18.copyWith(
                        shadows: [],
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const ForgetPassword(),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                // When the user taps the button, call the cubit method.
                final email = emailController.text;
                final password = passwordController.text;
                
                context.read<SignInCubit>().signIn(email, password, "users/login");
              },
              child: const MainBox(
                text: 'تسجيل الدخول',
                assetName: AssetsData.arrowIconInternal,
                numWidHig: 30,
                numRight: 22,
                numTop: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
