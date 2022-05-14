part of 'tarjeta_bloc.dart';

abstract class TarjetaState extends Equatable {
  const TarjetaState();

  @override
  List<Object> get props => [];
}

class TarjetaInitial extends TarjetaState {}

class TarjetaFetched extends TarjetaState {
  final List<Tarjeta> tarjetas;

  final String page;

  const TarjetaFetched(this.tarjetas, this.page);

  @override
  List<Object> get props => [tarjetas];
}

class TarjetaFetchError extends TarjetaState {
  final String message;
  const TarjetaFetchError(this.message);

  @override
  List<Object> get props => [message];
}
