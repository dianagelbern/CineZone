import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/cine/cine_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_cines_event.dart';
part 'get_cines_state.dart';

class GetCinesBloc extends Bloc<GetCinesEvent, GetCinesState> {
  final CineRepository cineRepository;

  GetCinesBloc(this.cineRepository) : super(GetCinesInitial()) {
    on<DoGetCinesEvent>(_getAllCines);
  }

  FutureOr<void> _getAllCines(
      DoGetCinesEvent event, Emitter<GetCinesState> emit) async {
    try {
      final response = await cineRepository.fetchCines(event.page);
      emit(GetCinesSuccessState(response));
      return;
    } on Exception catch (e) {
      emit(GetCinesErrorState(e.toString()));
    }
  }
}
