part of 'create_show_bloc.dart';

abstract class CreateShowEvent extends Equatable {
  const CreateShowEvent();

  @override
  List<Object> get props => [];
}

class CreateShow extends CreateShowEvent {
  final ShowDto showDto;

  const CreateShow(this.showDto);

  @override
  List<Object> get props => [];
}
