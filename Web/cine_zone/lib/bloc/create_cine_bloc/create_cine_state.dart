part of 'create_cine_bloc.dart';

abstract class CreateCineState extends Equatable {
  const CreateCineState();

  @override
  List<Object> get props => [];
}

class CreateCineInitial extends CreateCineState {}

class CreateCineLoadingState extends CreateCineState {}

class CreateCineSuccesState extends CreateCineState {
  final Cine cineResponse;

  const CreateCineSuccesState(this.cineResponse);

  @override
  List<Object> get props => [cineResponse];
}

class CreateCineErrorState extends CreateCineState {
  final String message;

  const CreateCineErrorState(this.message);

  @override
  List<Object> get props => [message];
}
