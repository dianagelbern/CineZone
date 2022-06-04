part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieWithType extends MoviesEvent {
  final String page;

  const FetchMovieWithType(this.page);

  @override
  List<Object> get props => [page];
}
