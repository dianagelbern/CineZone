import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/show/show_by_cine_response.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';
import 'package:equatable/equatable.dart';

part 'shows_by_cine_event.dart';
part 'shows_by_cine_state.dart';

class ShowsByCineBloc extends Bloc<ShowsByCineEvent, ShowsByCineState> {
  final ShowRepository showRepository;

  ShowsByCineBloc(this.showRepository) : super(ShowsByCineInitial()) {
    on<FetchShowsByCineWithPage>(_showsByCineFetched);
  }

  void _showsByCineFetched(
      FetchShowsByCineWithPage event, Emitter<ShowsByCineState> emit) async {
    try {
      final cineShow = await showRepository.fetchShowsByCine(
          event.id, event.fecha, event.page);
      emit(ShowsByCineFetched(cineShow));
      return;
    } on Exception catch (e) {
      emit(ShowsByCineFetchError(e.toString()));
    }
  }
}
