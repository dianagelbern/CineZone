part of 'shows_by_cine_bloc.dart';

abstract class ShowsByCineState extends Equatable {
  const ShowsByCineState();

  @override
  List<Object> get props => [];
}

class ShowsByCineInitial extends ShowsByCineState {}

class ShowsByCineFetched extends ShowsByCineState {
  final List<CineShow> shows;

  const ShowsByCineFetched(this.shows);

  @override
  List<Object> get props => [shows];
}

class ShowsByCineFetchError extends ShowsByCineState {
  final String message;
  const ShowsByCineFetchError(this.message);

  @override
  List<Object> get props => [message];
}
