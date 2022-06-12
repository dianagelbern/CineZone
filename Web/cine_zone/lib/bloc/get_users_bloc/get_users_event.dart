part of 'get_users_bloc.dart';

@immutable
abstract class GetUsersEvent extends Equatable {
  const GetUsersEvent();

  @override
  List<Object> get props => [];
}

class DoGetUsersEvent extends GetUsersEvent {
  final String page;

  DoGetUsersEvent(this.page);
}
