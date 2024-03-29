part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class MoviesFetched extends MoviesState {
  final List<MovieItem> movies;
  final String page;

  const MoviesFetched(this.movies, this.page);

  @override
  List<Object> get props => [movies];
}

class MovieFetchError extends MoviesState {
  final String message;
  const MovieFetchError(this.message);

  @override
  List<Object> get props => [message];
}
