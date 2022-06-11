part of 'show_by_movie_bloc.dart';

abstract class ShowByMovieEvent extends Equatable {
  const ShowByMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchShowByMovieWithPage extends ShowByMovieEvent {
  final String page;
  final int id;
  final String fecha;

  const FetchShowByMovieWithPage(this.id, this.fecha, this.page);

  @override
  List<Object> get props => [id, fecha, page];
}
