part of 'eliminar_tarjeta_bloc.dart';

abstract class EliminarTarjetaEvent extends Equatable {
  const EliminarTarjetaEvent();

  @override
  List<Object> get props => [];
}

class DoEliminarTarjetaEvent extends EliminarTarjetaEvent {
  final String id;
  const DoEliminarTarjetaEvent(this.id);
}
