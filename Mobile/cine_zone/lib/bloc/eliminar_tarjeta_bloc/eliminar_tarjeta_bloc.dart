import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository.dart';
import 'package:equatable/equatable.dart';

part 'eliminar_tarjeta_event.dart';
part 'eliminar_tarjeta_state.dart';

class EliminarTarjetaBloc
    extends Bloc<EliminarTarjetaEvent, EliminarTarjetaState> {
  final TarjetaRepository repository;

  EliminarTarjetaBloc(this.repository) : super(EliminarTarjetaInitial()) {
    on<DoEliminarTarjetaEvent>(_doEliminarTarjeta);
  }
  FutureOr<void> _doEliminarTarjeta(
      DoEliminarTarjetaEvent event, Emitter<EliminarTarjetaState> emit) async {
    try {
      await repository.eliminarTarjeta(event.id);
      emit(EliminarTarjetaSuccessState());
      return;
    } on Exception catch (e) {
      emit(EliminarTarjetaErrorState(e.toString()));
    }
  }
}
