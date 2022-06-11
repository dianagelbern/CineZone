import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/reserva/reserva_item_dto.dart';
import 'package:cine_zone/models/reserva/reservas_response.dart';
import 'package:cine_zone/repository/reserva_repository/reserva_repository.dart';
import 'package:equatable/equatable.dart';

part 'create_reserva_event.dart';
part 'create_reserva_state.dart';

class CreateReservaBloc extends Bloc<CreateReservaEvent, CreateReservaState> {
  final ReservaRepository reservaRepository;

  CreateReservaBloc(this.reservaRepository) : super(CreateReservaInitial()) {
    on<CreateReserva>(_doReserva);
  }

  Future<void> _doReserva(
      CreateReserva event, Emitter<CreateReservaState> emit) async {
    try {
      final reserva =
          await reservaRepository.createReserva(event.reservaItemDto);
      emit(CreateReservaSuccesState(reserva));
    } on Exception catch (e) {
      emit(CreateReservaErrorState(e.toString()));
    }
  }
}
