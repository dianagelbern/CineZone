import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/tarjeta/tarjeta_dto.dart';
import 'package:cine_zone/models/tarjeta/tarjeta_response.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository.dart';
import 'package:equatable/equatable.dart';

part 'create_tarjeta_event.dart';
part 'create_tarjeta_state.dart';

class CreateTarjetaBloc extends Bloc<CreateTarjetaEvent, CreateTarjetaState> {
  final TarjetaRepository tarjetaRepository;

  CreateTarjetaBloc(this.tarjetaRepository) : super(CreateTarjetaInitial()) {
    on<CreateTarjeta>(_doTarjeta);
  }

  Future<void> _doTarjeta(
      CreateTarjeta event, Emitter<CreateTarjetaState> emit) async {
    try {
      final tarjeta = await tarjetaRepository.createTarjeta(event.tarjetaDto);
      emit(CreateTarjetaSuccesState(tarjeta));
    } on Exception catch (e) {
      emit(CreateTarjetaErrorState(e.toString()));
    }
  }
}
