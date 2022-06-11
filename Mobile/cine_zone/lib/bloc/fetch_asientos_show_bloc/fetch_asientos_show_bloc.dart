import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/asientos_show/asientos_show_response.dart';
import 'package:cine_zone/repository/asientos_show_repository/asientos_show_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:timeago/timeago.dart';

part 'fetch_asientos_show_event.dart';
part 'fetch_asientos_show_state.dart';

class FetchAsientosShowBloc
    extends Bloc<FetchAsientosShowEvent, FetchAsientosShowState> {
  final AsientosShowRepository asientosShowRepository;

  FetchAsientosShowBloc(this.asientosShowRepository)
      : super(FetchAsientosShowInitial()) {
    on<FetchAsientosShowWithShow>(_asientosShowFetched);
  }

  void _asientosShowFetched(FetchAsientosShowWithShow event,
      Emitter<FetchAsientosShowState> emit) async {
    try {
      final asientosShow = await asientosShowRepository.fetchAsientos(event.id);
      emit(FetchAsientosShowFetched(asientosShow));
      return;
    } on Exception catch (e) {
      emit(FetchAsientosShowError(e.toString()));
    }
  }
}
