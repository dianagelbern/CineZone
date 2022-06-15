part of 'movie_item_bloc.dart';

abstract class MovieItemEvent extends Equatable {
  const MovieItemEvent();

  @override
  List<Object> get props => [];
}

class MovieItemFetchEvent extends MovieItemEvent {
  final String id;

  const MovieItemFetchEvent(this.id);

  @override
  List<Object> get props => [];
}
