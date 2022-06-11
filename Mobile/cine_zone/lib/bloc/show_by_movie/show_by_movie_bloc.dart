import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/show/show_by_movie_response.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';
import 'package:equatable/equatable.dart';

part 'show_by_movie_event.dart';
part 'show_by_movie_state.dart';

class ShowByMovieBloc extends Bloc<ShowByMovieEvent, ShowByMovieState> {
  final ShowRepository showRepository;

  ShowByMovieBloc(this.showRepository) : super(ShowByMovieInitial()) {
    on<FetchShowByMovieWithPage>(_showByMovieFetched);
  }

  void _showByMovieFetched(
      FetchShowByMovieWithPage event, Emitter<ShowByMovieState> emit) async {
    try {
      final movieShow = await showRepository.fetchShowsByMovie(
          event.id, event.fecha, event.page);
      emit(ShowByMovieFetched(movieShow));
      return;
    } on Exception catch (e) {
      emit(ShowsByMovieFetchError(e.toString()));
    }
  }
}
