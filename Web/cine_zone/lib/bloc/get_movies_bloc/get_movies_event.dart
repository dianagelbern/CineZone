part of 'get_movies_bloc.dart';

@immutable
abstract class GetMoviesEvent extends Equatable {
  const GetMoviesEvent();

  @override
  List<Object> get props => [];
}

class DoGetMoviesEvent extends GetMoviesEvent {
  final String page;

  DoGetMoviesEvent(this.page);
}
