import '../data/profile_model.dart';

class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final ProfileResponse profileResponse;

  ProfileSuccessState({required this.profileResponse});
}

class ProfileUpdateLoadingState extends ProfileState {}

class ProfileUpdateSuccessState extends ProfileState {
  final String message;

  ProfileUpdateSuccessState({required this.message});
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  ProfileErrorState({required this.errorMessage});
}