part of 'create_reserva_bloc.dart';

abstract class CreateReservaEvent extends Equatable {
  const CreateReservaEvent();

  @override
  List<Object> get props => [];
}

class CreateReserva extends CreateReservaEvent {
  final ReservaItemDto reservaItemDto;

  const CreateReserva(this.reservaItemDto);

  @override
  List<Object> get props => [];
}
