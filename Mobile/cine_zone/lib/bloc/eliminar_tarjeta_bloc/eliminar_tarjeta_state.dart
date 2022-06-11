part of 'eliminar_tarjeta_bloc.dart';

abstract class EliminarTarjetaState extends Equatable {
  const EliminarTarjetaState();

  @override
  List<Object> get props => [];
}

class EliminarTarjetaInitial extends EliminarTarjetaState {}

class EliminarTarjetaSuccessState extends EliminarTarjetaState {
  const EliminarTarjetaSuccessState();

  @override
  List<Object> get props => [];
}

class EliminarTarjetaLoadingState extends EliminarTarjetaState {}

class EliminarTarjetaErrorState extends EliminarTarjetaState {
  final String message;

  const EliminarTarjetaErrorState(this.message);

  @override
  List<Object> get props => [message];
}
