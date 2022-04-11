part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class CreateRegister extends RegisterEvent {
  final UserDto userDto;
  final String image;

  const CreateRegister(this.userDto, this.image);

  @override
  List<Object> get props => [];
}
