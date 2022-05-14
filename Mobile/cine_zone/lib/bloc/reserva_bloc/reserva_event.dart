part of 'reserva_bloc.dart';

abstract class ReservaEvent extends Equatable {
  const ReservaEvent();

  @override
  List<Object> get props => [];
}

class FetchReservaWithPage extends ReservaEvent {
  final String page;
  const FetchReservaWithPage(this.page);

  @override
  List<Object> get props => [page];
}

class ReservaFetchEvent extends ReservaEvent {
  const ReservaFetchEvent();

  @override
  List<Object> get props => [];
}
