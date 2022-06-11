part of 'shows_by_cine_bloc.dart';

abstract class ShowsByCineEvent extends Equatable {
  const ShowsByCineEvent();

  @override
  List<Object> get props => [];
}

class FetchShowsByCineWithPage extends ShowsByCineEvent {
  final String page;
  final int id;
  final String fecha;

  const FetchShowsByCineWithPage(this.id, this.fecha, this.page);

  @override
  List<Object> get props => [id, fecha, page];
}
