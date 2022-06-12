import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/show/show_by_sala_response.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'get_shows_from_sala_event.dart';
part 'get_shows_from_sala_state.dart';

class GetShowsFromSalaBloc
    extends Bloc<GetShowsFromSalaEvent, GetShowsFromSalaState> {
  final ShowRepository showRepository;
  GetShowsFromSalaBloc(this.showRepository) : super(GetShowsFromSalaInitial()) {
    on<DoGetShowsFromSalaEvent>(_getAlShowsFromSala);
  }

  FutureOr<void> _getAlShowsFromSala(DoGetShowsFromSalaEvent event,
      Emitter<GetShowsFromSalaState> emit) async {
    try {
      final response = await showRepository.fetchShowsBySalaAndDate(
          event.page, event.salaId, event.fecha);
      emit(GetShowsFromSalaSuccessState(response));
      return;
    } on Exception catch (e) {
      emit(GetShowsFromSalaErrorState(e.toString()));
    }
  }
}
