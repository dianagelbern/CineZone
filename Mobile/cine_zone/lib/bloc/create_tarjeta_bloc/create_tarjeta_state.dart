part of 'create_tarjeta_bloc.dart';

abstract class CreateTarjetaState extends Equatable {
  const CreateTarjetaState();

  @override
  List<Object> get props => [];
}

class CreateTarjetaInitial extends CreateTarjetaState {}

class CreateTarjetaSuccesState extends CreateTarjetaState {
  final Tarjeta reservaResponse;

  const CreateTarjetaSuccesState(this.reservaResponse);

  @override
  List<Object> get props => [reservaResponse];
}

class CreateTarjetaErrorState extends CreateTarjetaState {
  final String message;

  const CreateTarjetaErrorState(this.message);

  @override
  List<Object> get props => [message];
}
