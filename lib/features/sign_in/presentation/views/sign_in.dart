import 'package:eye/core/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/api_service.dart';
import 'widgets/sign_in_body.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(apiService:  ApiService()),
      child: const Scaffold(
        body: SignInBody(),
      ),
    );
  }
}
