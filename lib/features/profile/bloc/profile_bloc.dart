import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_app/features/auth/data/repositories/api_services.dart';
import 'package:login_register_app/features/profile/bloc/profile_event.dart';
import 'package:login_register_app/features/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiServices apiServices;
  ProfileBloc(this.apiServices) : super(ProfileInitialState()) {
    //fetch user data
    on<FetchProfileDataEvent>((event, emit) async {
      emit(ProfileLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      try {
        final data = await apiServices.showServerResponse();
        print('bloc $data');
        emit(ProfileSuccessState(data));
      } catch (e) {
        emit(ProfileFailureState(e.toString()));
      }
    });
  }
}
