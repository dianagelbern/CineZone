part of 'edit_user_bloc.dart';

abstract class EditUserState extends Equatable {
  const EditUserState();

  @override
  List<Object> get props => [];
}

class EditUserInitial extends EditUserState {}

class EditUserSuccesState extends EditUserState {
  final UserResponse reservaResponse;

  const EditUserSuccesState(this.reservaResponse);

  @override
  List<Object> get props => [reservaResponse];
}

class EditUserErrorState extends EditUserState {
  final String message;

  const EditUserErrorState(this.message);

  @override
  List<Object> get props => [message];
}
