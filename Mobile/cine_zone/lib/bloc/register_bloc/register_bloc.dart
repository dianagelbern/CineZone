import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/auth/login_response.dart';
import 'package:cine_zone/models/user/user_dto.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  RegisterBloc(this.userRepository) : super(RegisterInitial()) {
    on<CreateRegister>(_doRegister);
  }

  Future<void> _doRegister(
      CreateRegister event, Emitter<RegisterState> emit) async {
    try {
      final register = await userRepository.crearRegistro(event.userDto);
      emit(RegisterSuccesState(register));
      return;
    } on Exception catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
