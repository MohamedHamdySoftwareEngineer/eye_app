// Coordinates the login process and maps repository results into UI states.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/services/auth_repository.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  LoginCubit({required this.authRepository}) : super(LoginInitial());

  

  Future<void> logIn(
      {required String username, required String password}) async {
    emit(LoginLoading());
    try {
      final token = await authRepository.authenticate(
          username: username, password: password);
      emit(LoginSuccess(token));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
