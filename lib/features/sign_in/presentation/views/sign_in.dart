import 'package:eye/core/utils/api_service.dart';
import 'package:eye/features/sign_in/data/repos/sign_in_repo.dart';
import 'package:eye/features/sign_in/data/repos/sign_in_repo_Impl.dart';
import 'package:eye/features/sign_in/presentation/manager/features/sign_in/presentation/cubit/sign_in_cubit.dart';
import 'package:eye/features/sign_in/presentation/manager/features/sign_in/presentation/cubit/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import 'widgets/sign_in_body.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignInCubit(signInRepo: SignInRepoImpl(apiService: ApiService())),
      child: Scaffold(
        body: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              GoRouter.of(context).push(AppRouter.rLeaderboard);
              
            } else if (state is SignInFailure) {
              
            //    ScaffoldMessenger.of(context).showSnackBar(
            //    const SnackBar(
            //     content: Text('sign in failed!',),
            //     duration: Duration(seconds: 1),
                
            //   ),
            // );
            GoRouter.of(context).push(AppRouter.rLeaderboard);
            }
          },
          builder: (context, state) {
            
            return const SignInBody();
          },
        ),
      ),
    );
  }
}
