import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/sala/sala_from_cine_response.dart';
import 'package:cine_zone/repository/sala_repository.dart/salas_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'get_salas_from_cine_event.dart';
part 'get_salas_from_cine_state.dart';

class GetSalasFromCineBloc
    extends Bloc<GetSalasFromCineEvent, GetSalasFromCineState> {
  final SalaRepository salaRepository;

  GetSalasFromCineBloc(this.salaRepository) : super(GetSalasFromCineInitial()) {
    on<DoGetSalasFromCineEvent>(_getAllSalasFromCine);
  }

  FutureOr<void> _getAllSalasFromCine(DoGetSalasFromCineEvent event,
      Emitter<GetSalasFromCineState> emit) async {
    try {
      final response =
          await salaRepository.getAllSalasFromCine(event.page, event.cineId);
      emit(GetSalasFromCineSuccessState(response));
      return;
    } on Exception catch (e) {
      emit(GetSalasFromCineErrorState(e.toString()));
    }
  }
}
