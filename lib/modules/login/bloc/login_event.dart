import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {}

class LoginSubmitEvent extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class ObscureButtonEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
