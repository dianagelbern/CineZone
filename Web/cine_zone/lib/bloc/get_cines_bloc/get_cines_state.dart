part of 'get_cines_bloc.dart';

abstract class GetCinesState extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCinesInitial extends GetCinesState {}

class GetCinesSuccessState extends GetCinesState {
  final List<Cine> cineList;

  GetCinesSuccessState(this.cineList);

  @override
  List<Object> get props => [cineList];
}

class GetCinesErrorState extends GetCinesState {
  final String message;

  GetCinesErrorState(this.message);

  @override
  List<Object> get props => [message];
}
