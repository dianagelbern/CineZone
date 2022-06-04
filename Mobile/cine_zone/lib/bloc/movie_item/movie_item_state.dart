part of 'movie_item_bloc.dart';

abstract class MovieItemState extends Equatable {
  const MovieItemState();

  @override
  List<Object> get props => [];
}

class MovieItemInitial extends MovieItemState {}

class MovieItemfetchedState extends MovieItemState {
  final MovieItem movie;

  const MovieItemfetchedState(this.movie);

  @override
  List<Object> get props => [];
}

class MovieItemFetchError extends MovieItemState {
  final String message;

  const MovieItemFetchError(this.message);

  @override
  List<Object> get props => [];
}
