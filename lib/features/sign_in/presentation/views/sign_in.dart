import 'package:eye/core/services/api_service.dart';
import 'package:eye/features/sign_in/presentation/manager/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/auth_repository.dart';
import 'widgets/sign_in_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (_) {
        final apiService = ApiService();
        final authRepo   = AuthRepository(apiService: apiService);
        return LoginCubit(authRepository: authRepo);
      },
      child:   const Scaffold(
        body: SignInBody(),
      ),
    );
  }
}
