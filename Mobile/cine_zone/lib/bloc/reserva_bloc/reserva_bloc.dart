import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/reserva/reservas_response.dart';
import 'package:cine_zone/repository/reserva_repository/reserva_repository.dart';
import 'package:equatable/equatable.dart';

part 'reserva_event.dart';
part 'reserva_state.dart';

class ReservaBloc extends Bloc<ReservaEvent, ReservaState> {
  final ReservaRepository reservaRepository;

  ReservaBloc(this.reservaRepository) : super(ReservaInitial()) {
    on<FetchReservaWithPage>(_reservaFetched);
  }

  void _reservaFetched(
      FetchReservaWithPage event, Emitter<ReservaState> emit) async {
    try {
      final reserva = await reservaRepository.fetchReservas(event.page);
      emit(ReservaFetched(reserva, event.page));
      return;
    } on Exception catch (e) {
      emit(ReservaFetchError(e.toString()));
    }
  }
}
