part of 'fetch_asientos_show_bloc.dart';

abstract class FetchAsientosShowState extends Equatable {
  const FetchAsientosShowState();

  @override
  List<Object> get props => [];
}

class FetchAsientosShowInitial extends FetchAsientosShowState {}

class FetchAsientosShowFetched extends FetchAsientosShowState {
  final List<AsientoShow> asientosShow;

  const FetchAsientosShowFetched(this.asientosShow);

  @override
  List<Object> get props => [asientosShow];
}

class FetchAsientosShowError extends FetchAsientosShowState {
  final String message;
  const FetchAsientosShowError(this.message);

  @override
  List<Object> get props => [message];
}
