part of 'reserva_bloc.dart';

abstract class ReservaState extends Equatable {
  const ReservaState();

  @override
  List<Object> get props => [];
}

class ReservaInitial extends ReservaState {}

class ReservaFetched extends ReservaState {
  final List<Reserva> reservas;
  final String page;

  const ReservaFetched(this.reservas, this.page);

  @override
  List<Object> get props => [reservas];
}

class ReservaFetchError extends ReservaState {
  final String message;
  const ReservaFetchError(this.message);

  @override
  List<Object> get props => [message];
}
