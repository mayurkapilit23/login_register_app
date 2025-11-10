import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/modules/login/bloc/login_event.dart';
import 'package:login_register_app/modules/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool _isObscure = true;

  LoginBloc() : super(LoginInitialState()) {
    //loginSubmit event

    on<LoginSubmitEvent>(_handleLoginSubmitEvent);

    on<ObscureButtonEvent>(_onObscureButtonState);
  }

  Future<void> _handleLoginSubmitEvent(
    LoginSubmitEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Add a delay of 2 seconds

    final isValidInput = _isValidInput(event.email, event.password);

    if (isValidInput) {
      emit(LoginSuccessState(event.email));
    } else {
      emit(LoginErrorState('Invalid input'));
    }
  }

  bool _isValidInput(String email, String password) =>
      email == 'user' && password == 'user';

  void _onObscureButtonState(event, emit) {
    _isObscure = !_isObscure;
    emit(ObscureButtonState(isObscure: _isObscure));
  }
}
