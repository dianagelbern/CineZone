part of 'fetch_asientos_show_bloc.dart';

abstract class FetchAsientosShowEvent extends Equatable {
  const FetchAsientosShowEvent();

  @override
  List<Object> get props => [];
}

class FetchAsientosShowWithShow extends FetchAsientosShowEvent {
  final String id;

  const FetchAsientosShowWithShow(this.id);

  @override
  List<Object> get props => [id];
}
