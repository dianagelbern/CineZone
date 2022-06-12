part of 'edit_user_bloc.dart';

abstract class EditUserEvent extends Equatable {
  const EditUserEvent();

  @override
  List<Object> get props => [];
}

class DoEditUser extends EditUserEvent {
  final NewUserDto newUser;

  const DoEditUser(this.newUser);

  @override
  List<Object> get props => [];
}
