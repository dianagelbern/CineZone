import 'package:bloc/bloc.dart';
import 'package:cine_zone/bloc/get_cines_bloc/get_cines_bloc.dart';
import 'package:equatable/equatable.dart';

class GetCinesBloc extends Bloc<GetCinesEvent, GetCinesState> {
  GetCinesBloc() : super(GetCinesInitial()) {
    on<GetCinesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
