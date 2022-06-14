part of 'create_show_bloc.dart';

abstract class CreateShowState extends Equatable {
  const CreateShowState();

  @override
  List<Object> get props => [];
}

class CreateShowInitial extends CreateShowState {}

class CreateShowLoadingState extends CreateShowState {}

class CreateShowSuccesState extends CreateShowState {
  final Show showResponse;

  const CreateShowSuccesState(this.showResponse);

  @override
  List<Object> get props => [showResponse];
}

class CreateShowErrorState extends CreateShowState {
  final String message;

  const CreateShowErrorState(this.message);

  @override
  List<Object> get props => [message];
}
