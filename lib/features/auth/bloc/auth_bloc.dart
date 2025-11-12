import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/features/auth/bloc/auth_event.dart';
import 'package:login_register_app/features/auth/bloc/auth_state.dart';

import '../data/repositories/api_services.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool _isObscure = true;
  final ApiServices apiServices;

  AuthBloc(this.apiServices) : super(AuthInitialState()) {
    //loginSubmit event

    // on<LoginSubmitEvent>(_handleLoginSubmitEvent);

    on<NavigateToRegisterEvent>(_navigateToRegisterScreen);
    on<NavigateToLoginEvent>(_navigateToLoginScreen);
    on<ObscureButtonEvent>(_onObscureButtonState);
    on<RegisterNewUserEvent>(_registerNewUserEvent);
    on<LoginUserEvent>(_loginUserEvent);
  }

  Future<void> _loginUserEvent(
    LoginUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingState());
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Add a delay of 2 seconds

      // final isValidInput = _isValidInput(event.email, event.password);
      final userLogin = await apiServices.userLogin(
        event.email,
        event.password,
      );

      emit(AuthSuccessState(userLogin['message']));
      emit(AuthSuccessState(userLogin['user']));
    } catch (e) {
      emit(AuthErrorState('Error: ${e.toString()}'));
      print('Error: ${e.toString()}');
    }
  }

  bool _isValidInput(email, password) {
    if (email == null && password == null) {
      return false;
    } else {
      return true;
    }
  }

  void _onObscureButtonState(event, emit) {
    _isObscure = !_isObscure;
    emit(ObscureButtonState(isObscure: _isObscure));
  }

  Future<void> _registerNewUserEvent(
    RegisterNewUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingState());
      await Future.delayed(const Duration(seconds: 2));

      final newUser = await apiServices.userRegister(
        event.email,
        event.password,
      );

      emit(AuthSuccessState(newUser['message']));
    } catch (e) {
      emit(AuthErrorState('Error: ${e.toString()}'));
      print('Error: ${e.toString()}');
    }
  }

  Future<void> _navigateToRegisterScreen(
    NavigateToRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(AuthNavigateToRegisterState());
  }

  Future<void> _navigateToLoginScreen(
    NavigateToLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(AuthNavigateToLoginState());
  }
}
