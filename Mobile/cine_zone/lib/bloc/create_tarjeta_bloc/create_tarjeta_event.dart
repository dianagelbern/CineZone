part of 'create_tarjeta_bloc.dart';

abstract class CreateTarjetaEvent extends Equatable {
  const CreateTarjetaEvent();

  @override
  List<Object> get props => [];
}

class CreateTarjeta extends CreateTarjetaEvent {
  final TarjetaDto tarjetaDto;

  const CreateTarjeta(this.tarjetaDto);

  @override
  List<Object> get props => [];
}
