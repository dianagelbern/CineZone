part of 'get_movies_bloc.dart';

@immutable
abstract class GetMoviesState {}

class GetMoviesInitial extends GetMoviesState {}

class GetMoviesSuccessState extends GetMoviesState {
  final List<Movie> movieList;

  GetMoviesSuccessState(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class GetMoviesErrorState extends GetMoviesState {
  final String message;

  GetMoviesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
