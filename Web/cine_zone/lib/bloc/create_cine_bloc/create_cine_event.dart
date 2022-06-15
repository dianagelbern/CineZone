part of 'create_cine_bloc.dart';

abstract class CreateCineEvent extends Equatable {
  const CreateCineEvent();

  @override
  List<Object> get props => [];
}

class CreateCine extends CreateCineEvent {
  final CineDto cineDto;

  const CreateCine(this.cineDto);

  @override
  List<Object> get props => [];
}
