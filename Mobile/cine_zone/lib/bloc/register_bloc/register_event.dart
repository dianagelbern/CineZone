part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class CreateRegister extends RegisterEvent {
  final UserDto userDto;

  const CreateRegister(this.userDto);

  @override
  List<Object> get props => [];
}
