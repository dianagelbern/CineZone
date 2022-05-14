import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/tarjeta/tarjeta_response.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository.dart';
import 'package:equatable/equatable.dart';

part 'tarjeta_event.dart';
part 'tarjeta_state.dart';

class TarjetaBloc extends Bloc<TarjetaEvent, TarjetaState> {
  final TarjetaRepository tarjetaRepository;

  TarjetaBloc(this.tarjetaRepository) : super(TarjetaInitial()) {
    on<FetchTarjetaWithPage>(_tarjetaFetched);
  }

  void _tarjetaFetched(
      FetchTarjetaWithPage event, Emitter<TarjetaState> emit) async {
    try {
      final tarjeta = await tarjetaRepository.fetchTarjetas(event.page);
      emit(TarjetaFetched(tarjeta, event.page));
      return;
    } on Exception catch (e) {
      emit(TarjetaFetchError(e.toString()));
    }
  }
}
