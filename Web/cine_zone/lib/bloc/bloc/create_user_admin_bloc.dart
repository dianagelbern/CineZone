import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/user/user_admin_dto.dart';
import 'package:cine_zone/models/user/users_response.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'create_user_admin_event.dart';
part 'create_user_admin_state.dart';

class CreateUserAdminBloc
    extends Bloc<CreateUserAdminEvent, CreateUserAdminState> {
  final UserRepository userRepository;
  CreateUserAdminBloc(this.userRepository) : super(CreateUserAdminInitial()) {
    on<CreateUserAdmin>(_doNewUserAdmin);
  }

  Future<void> _doNewUserAdmin(
      CreateUserAdmin event, Emitter<CreateUserAdminState> emit) async {
    try {
      final user = await userRepository.createNewUSer(event.userAdminDto);
      emit(CreateUserAdminSuccesState(user));
    } on Exception catch (e) {
      emit(CreateUserAdminErrorState(e.toString()));
    }
  }
}
