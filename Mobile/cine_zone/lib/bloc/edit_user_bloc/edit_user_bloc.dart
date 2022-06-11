import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/user/new_user_dto.dart';
import 'package:cine_zone/models/user/user_dto.dart';
import 'package:cine_zone/models/user/user_response.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'edit_user_event.dart';
part 'edit_user_state.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final UserRepository userRepository;

  EditUserBloc(this.userRepository) : super(EditUserInitial()) {
    on<DoEditUser>(_doEdit);
  }

  Future<void> _doEdit(DoEditUser event, Emitter<EditUserState> emit) async {
    try {
      final newUser = await userRepository.editUserProfile(event.newUser);
      emit(EditUserSuccesState(newUser));
    } on Exception catch (e) {
      emit(EditUserErrorState(e.toString()));
    }
  }
}
