part of 'cines_bloc.dart';

abstract class CinesState extends Equatable {
  const CinesState();

  @override
  List<Object> get props => [];
}

class CinesInitial extends CinesState {}

class CinesFetched extends CinesState {
  final List<Cine> cine;
  final String page;

  const CinesFetched(this.cine, this.page);

  @override
  List<Object> get props => [cine];
}

class CinesFetchError extends CinesState {
  final String message;
  const CinesFetchError(this.message);

  @override
  List<Object> get props => [message];
}
