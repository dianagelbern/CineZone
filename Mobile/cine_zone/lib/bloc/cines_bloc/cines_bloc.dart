import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/cine/cines_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:equatable/equatable.dart';

part 'cines_event.dart';
part 'cines_state.dart';

class CinesBloc extends Bloc<CinesEvent, CinesState> {
  final CineRepository cineRepository;
  CinesBloc(this.cineRepository) : super(CinesInitial()) {
    on<FetchCineWithType>(_cinesFetched);
  }

  void _cinesFetched(FetchCineWithType event, Emitter<CinesState> emit) async {
    try {
      final cines = await cineRepository.fetchCines(event.page);
      emit(CinesFetched(cines, event.page));
      return;
    } on Exception catch (e) {
      emit(CinesFetchError(e.toString()));
    }
  }
}
