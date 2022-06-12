part of 'get_users_bloc.dart';

@immutable
abstract class GetUsersState {}

class GetUsersInitial extends GetUsersState {}

class GetUsersSuccessState extends GetUsersState {
  final List<User> userList;

  GetUsersSuccessState(this.userList);

  @override
  List<Object> get props => [userList];
}

class GetUsersErrorState extends GetUsersState {
  final String message;

  GetUsersErrorState(this.message);

  @override
  List<Object> get props => [message];
}
