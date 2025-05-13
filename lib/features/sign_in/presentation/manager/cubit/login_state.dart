// Defines the Cubit states: initial, loading, success (with token), and failure (with error).
part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String token;
  const LoginSuccess(this.token);
}

final class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure(this.errorMessage);
}
