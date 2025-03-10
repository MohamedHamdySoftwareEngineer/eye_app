import 'package:eye/features/sign_in/data/repos/sign_in_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInRepo signInRepo;

  SignInCubit({required this.signInRepo}) : super(SignInInitial());

  Future<void> signIn(String email, String password,String endPoint) async {
    emit(SignInLoading());

    // Assuming your signIn method returns a Future<Either<Failures, Response>>
    final result = await signInRepo.signIn(email, password,endPoint);

    result.fold(
      // In case of failure, emit AuthFailure with the failure message
      (failure) => emit(SignInFailure(failure.errorMessage)),
      // In case of success, extract the token and emit AuthSuccess
      (response) {
        final token = response.data['token']; // Adjust this based on your API response
        emit(SignInSuccess(token));
      },
    );
  }
}
