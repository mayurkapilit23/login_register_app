import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class FetchProfileDataEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
