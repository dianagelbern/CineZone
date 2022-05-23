part of 'get_cines_bloc.dart';

abstract class GetCinesEvent extends Equatable {
  const GetCinesEvent();

  @override
  List<Object> get props => [];
}

class DoGetCinesEvent extends GetCinesEvent {
  final String page;

  DoGetCinesEvent(this.page);
}
