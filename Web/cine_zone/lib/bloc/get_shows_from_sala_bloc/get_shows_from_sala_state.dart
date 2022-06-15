part of 'get_shows_from_sala_bloc.dart';

@immutable
abstract class GetShowsFromSalaState {}

class GetShowsFromSalaInitial extends GetShowsFromSalaState {}

class GetShowsFromSalaSuccessState extends GetShowsFromSalaState {
  final List<Show> showsList;

  GetShowsFromSalaSuccessState(this.showsList);

  @override
  List<Object> get props => [showsList];
}

class GetShowsFromSalaErrorState extends GetShowsFromSalaState {
  final String message;

  GetShowsFromSalaErrorState(this.message);

  @override
  List<Object> get props => [message];
}
