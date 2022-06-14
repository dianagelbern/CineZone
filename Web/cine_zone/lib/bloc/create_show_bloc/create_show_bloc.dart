import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/show/show_by_sala_response.dart';
import 'package:cine_zone/models/show/show_dto.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'create_show_event.dart';
part 'create_show_state.dart';

class CreateShowBloc extends Bloc<CreateShowEvent, CreateShowState> {
  final ShowRepository showRepository;
  CreateShowBloc(this.showRepository) : super(CreateShowInitial()) {
    on<CreateShow>(_doShow);
  }

  Future<void> _doShow(CreateShow event, Emitter<CreateShowState> emit) async {
    try {
      final show = await showRepository.createShow(event.showDto);
      emit(CreateShowSuccesState(show));
    } on Exception catch (e) {
      emit(CreateShowErrorState(e.toString()));
    }
  }
}
