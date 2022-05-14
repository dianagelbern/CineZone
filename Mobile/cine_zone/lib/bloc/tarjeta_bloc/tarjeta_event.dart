part of 'tarjeta_bloc.dart';

abstract class TarjetaEvent extends Equatable {
  const TarjetaEvent();

  @override
  List<Object> get props => [];
}

class FetchTarjetaWithPage extends TarjetaEvent {
  final String page;

  const FetchTarjetaWithPage(this.page);

  @override
  List<Object> get props => [page];
}
