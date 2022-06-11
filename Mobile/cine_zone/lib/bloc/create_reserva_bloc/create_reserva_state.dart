part of 'create_reserva_bloc.dart';

abstract class CreateReservaState extends Equatable {
  const CreateReservaState();

  @override
  List<Object> get props => [];
}

class CreateReservaInitial extends CreateReservaState {}

class CreateReservaLoadingState extends CreateReservaState {}

class CreateReservaSuccesState extends CreateReservaState {
  final Reserva reservaResponse;

  const CreateReservaSuccesState(this.reservaResponse);

  @override
  List<Object> get props => [reservaResponse];
}

class CreateReservaErrorState extends CreateReservaState {
  final String message;

  const CreateReservaErrorState(this.message);

  @override
  List<Object> get props => [message];
}
