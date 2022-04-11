part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccesState extends RegisterState {
  final LoginResponse userResponse;

  const RegisterSuccesState(this.userResponse);

  @override
  List<Object> get props => [userResponse];
}

class RegisterErrorState extends RegisterState {
  final String message;

  const RegisterErrorState(this.message);

  @override
  List<Object> get props => [message];
}
