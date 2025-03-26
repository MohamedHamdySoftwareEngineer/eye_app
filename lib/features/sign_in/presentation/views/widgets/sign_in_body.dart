import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_router.dart';
import 'package:eye/core/utils/assets.dart';
import 'package:eye/core/widgets/main_box.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/email_box.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/forget_password.dart';
import 'package:eye/features/sign_in/presentation/views/widgets/password_box.dart';
import '../../../../../core/utils/styles.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  // Controllers to capture user input.
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Function to call the backend API for sign in.
  Future<void> _signIn() async {
    final username = emailController.text;
    final password = passwordController.text;
    // const String apiUrl = "http://10.0.2.2:5216/api/users/login";
    const String apiUrl = "http://192.168.20.30:5236/api/users/login";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        GoRouter.of(context).go(AppRouter.rHomeView);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Login failed. Please check your credentials.")),
        );
      }
    } catch (e) {
      print("An error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
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
            // Pass the controllers to your custom widgets.
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
                print('button Tapped');
                _signIn();
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
