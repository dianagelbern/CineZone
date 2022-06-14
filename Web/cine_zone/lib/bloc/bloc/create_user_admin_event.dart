part of 'create_user_admin_bloc.dart';

abstract class CreateUserAdminEvent extends Equatable {
  const CreateUserAdminEvent();

  @override
  List<Object> get props => [];
}

class CreateUserAdmin extends CreateUserAdminEvent {
  final UserAdminDto userAdminDto;

  const CreateUserAdmin(this.userAdminDto);

  @override
  List<Object> get props => [];
}
