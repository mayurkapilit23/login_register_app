import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  // only static page
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  // only show login CircularIndicator
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  // show data
  final String email;
  LoginSuccessState(this.email);
  @override
  List<Object?> get props => [email];
}

class LoginErrorState extends LoginState {
  // show & handle error
  final String error;

  LoginErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class ObscureButtonState extends LoginState {
  final bool isObscure;

  ObscureButtonState({required this.isObscure});

  @override
  List<Object?> get props => [isObscure];
}
