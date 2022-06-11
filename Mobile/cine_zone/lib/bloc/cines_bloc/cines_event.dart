part of 'cines_bloc.dart';

abstract class CinesEvent extends Equatable {
  const CinesEvent();

  @override
  List<Object> get props => [];
}

class FetchCineWithType extends CinesEvent {
  final String page;

  const FetchCineWithType(this.page);

  @override
  List<Object> get props => [page];
}
