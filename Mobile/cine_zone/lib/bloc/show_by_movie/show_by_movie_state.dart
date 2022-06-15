part of 'show_by_movie_bloc.dart';

abstract class ShowByMovieState extends Equatable {
  const ShowByMovieState();

  @override
  List<Object> get props => [];
}

class ShowByMovieInitial extends ShowByMovieState {}

class ShowByMovieFetched extends ShowByMovieState {
  final List<MovieShow> shows;

  const ShowByMovieFetched(this.shows);

  @override
  List<Object> get props => [shows];
}

class ShowsByMovieFetchError extends ShowByMovieState {
  final String message;
  const ShowsByMovieFetchError(this.message);

  @override
  List<Object> get props => [message];
}
