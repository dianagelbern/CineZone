part of 'get_salas_from_cine_bloc.dart';

abstract class GetSalasFromCineState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSalasFromCineInitial extends GetSalasFromCineState {}

class GetSalasFromCineSuccessState extends GetSalasFromCineState {
  final SalasFromCineResponse cineList;

  GetSalasFromCineSuccessState(this.cineList);

  @override
  List<Object> get props => [cineList];
}

class GetSalasFromCineErrorState extends GetSalasFromCineState {
  final String message;

  GetSalasFromCineErrorState(this.message);

  @override
  List<Object> get props => [message];
}
