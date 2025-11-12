import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final Map<String, dynamic>? userData;
  ProfileSuccessState(this.userData);
  @override
  List<Object?> get props => [userData];
}

class ProfileFailureState extends ProfileState {
  final String errorMsg;
  ProfileFailureState(this.errorMsg);
  @override
  List<Object?> get props => [errorMsg];
}
