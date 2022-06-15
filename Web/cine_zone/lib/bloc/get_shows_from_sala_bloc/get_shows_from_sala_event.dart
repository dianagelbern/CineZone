part of 'get_shows_from_sala_bloc.dart';

@immutable
abstract class GetShowsFromSalaEvent extends Equatable {
  const GetShowsFromSalaEvent();

  @override
  List<Object> get props => [];
}

class DoGetShowsFromSalaEvent extends GetShowsFromSalaEvent {
  final String page;
  final String salaId;
  final String fecha;

  DoGetShowsFromSalaEvent(this.page, this.salaId, this.fecha);
}
