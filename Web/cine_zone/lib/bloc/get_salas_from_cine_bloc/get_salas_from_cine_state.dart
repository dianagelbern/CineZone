part of 'get_salas_from_cine_bloc.dart';

abstract class GetSalasFromCineState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSalasFromCineInitial extends GetSalasFromCineState {}

class GetSalasFromCineSuccessState extends GetSalasFromCineState {
  final List<Sala> salaList;

  GetSalasFromCineSuccessState(this.salaList);

  @override
  List<Object> get props => [salaList];
}

class GetSalasFromCineErrorState extends GetSalasFromCineState {
  final String message;

  GetSalasFromCineErrorState(this.message);

  @override
  List<Object> get props => [message];
}
