import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/user/users_response.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'get_users_event.dart';
part 'get_users_state.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersState> {
  final UserRepository userRepository;

  GetUsersBloc(this.userRepository) : super(GetUsersInitial()) {
    on<DoGetUsersEvent>(_getAllusers);
  }

  FutureOr<void> _getAllusers(
      DoGetUsersEvent event, Emitter<GetUsersState> emit) async {
    try {
      final response = await userRepository.fetchUsers(event.page);
      emit(GetUsersSuccessState(response));
      return;
    } on Exception catch (e) {
      emit(GetUsersErrorState(e.toString()));
    }
  }
}
