import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/user/user_response.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  ProfileBloc(this.userRepository) : super(ProfileInitial()) {
    on<ProfileFetchEvent>(_profile);
  }
  FutureOr<void> _profile(
      ProfileFetchEvent event, Emitter<ProfileState> emit) async {
    try {
      final userProfile = await userRepository.fetchUserProfile();
      emit(ProfileFetchedState(userProfile));
    } on Exception catch (e) {
      emit(ProfileFetchError(e.toString()));
    }
  }
}
