part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileFetchedState extends ProfileState {
  final UserResponse userResponse;

  const ProfileFetchedState(this.userResponse);

  @override
  List<Object> get props => [userResponse];
}

class ProfileFetchError extends ProfileState {
  final String message;

  const ProfileFetchError(this.message);

  @override
  List<Object> get props => [message];
}
