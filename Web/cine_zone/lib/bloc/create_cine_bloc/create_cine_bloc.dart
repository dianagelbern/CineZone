import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/cine/cine_dto.dart';
import 'package:cine_zone/models/cine/cine_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'create_cine_event.dart';
part 'create_cine_state.dart';

class CreateCineBloc extends Bloc<CreateCineEvent, CreateCineState> {
  final CineRepository cineRepository;
  CreateCineBloc(this.cineRepository) : super(CreateCineInitial()) {
    on<CreateCine>(_doCine);
  }

  Future<void> _doCine(CreateCine event, Emitter<CreateCineState> emit) async {
    try {
      final cine = await cineRepository.createCine(event.cineDto);
      emit(CreateCineSuccesState(cine));
    } on Exception catch (e) {
      emit(CreateCineErrorState(e.toString()));
    }
  }
}
