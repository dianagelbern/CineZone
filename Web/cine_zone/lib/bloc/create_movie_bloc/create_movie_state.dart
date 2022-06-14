part of 'create_movie_bloc.dart';

@immutable
abstract class CreateMovieState extends Equatable {
  const CreateMovieState();

  @override
  List<Object> get props => [];
}

class CreateMovieInitial extends CreateMovieState {}

class CreateMovieLoadingState extends CreateMovieState {}

class CreateMovieSuccesState extends CreateMovieState {
  final Movie movie;

  const CreateMovieSuccesState(this.movie);

  @override
  List<Object> get props => [movie];
}

class CreateMovieErrorState extends CreateMovieState {
  final String message;

  const CreateMovieErrorState(this.message);

  @override
  List<Object> get props => [message];
}
