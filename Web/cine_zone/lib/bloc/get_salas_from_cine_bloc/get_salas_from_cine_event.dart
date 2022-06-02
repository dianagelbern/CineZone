part of 'get_salas_from_cine_bloc.dart';

abstract class GetSalasFromCineEvent extends Equatable {
  const GetSalasFromCineEvent();

  @override
  List<Object> get props => [];
}

class DoGetSalasFromCineEvent extends GetSalasFromCineEvent {
  final String page;
  final String cineId;

  DoGetSalasFromCineEvent(this.page, this.cineId);
}
