import 'package:equatable/equatable.dart';



abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final String token; 

  const SignInSuccess(this.token);

  @override
  List<Object> get props => [token];
}

class SignInFailure extends SignInState {
  final String errorMessage;

  const SignInFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
