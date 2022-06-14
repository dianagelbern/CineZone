part of 'create_user_admin_bloc.dart';

abstract class CreateUserAdminState extends Equatable {
  const CreateUserAdminState();

  @override
  List<Object> get props => [];
}

class CreateUserAdminInitial extends CreateUserAdminState {}

class CreateUserAdminLoadingState extends CreateUserAdminState {}

class CreateUserAdminSuccesState extends CreateUserAdminState {
  final User userAdminResponse;

  const CreateUserAdminSuccesState(this.userAdminResponse);

  @override
  List<Object> get props => [userAdminResponse];
}

class CreateUserAdminErrorState extends CreateUserAdminState {
  final String message;

  const CreateUserAdminErrorState(this.message);

  @override
  List<Object> get props => [message];
}
