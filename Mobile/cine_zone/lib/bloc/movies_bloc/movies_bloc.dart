import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/movie/movie_response.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:equatable/equatable.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepository movieRepository;

  MoviesBloc(this.movieRepository) : super(MoviesInitial()) {
    on<FetchMovieWithType>(_moviesFetched);
  }

  void _moviesFetched(
      FetchMovieWithType event, Emitter<MoviesState> emit) async {
    try {
      final movies = await movieRepository.fetchMovies(event.page);
      emit(MoviesFetched(movies, event.page));
      return;
    } on Exception catch (e) {
      emit(MovieFetchError(e.toString()));
    }
  }
}
