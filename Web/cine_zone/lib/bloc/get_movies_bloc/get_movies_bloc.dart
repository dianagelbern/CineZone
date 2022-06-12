import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/movie/movies_response.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'get_movies_event.dart';
part 'get_movies_state.dart';

class GetMoviesBloc extends Bloc<GetMoviesEvent, GetMoviesState> {
  final MovieRepository movieRepository;

  GetMoviesBloc(this.movieRepository) : super(GetMoviesInitial()) {
    on<DoGetMoviesEvent>(_getAllMovies);
  }

  FutureOr<void> _getAllMovies(
      DoGetMoviesEvent event, Emitter<GetMoviesState> emit) async {
    try {
      final response = await movieRepository.fetchMovies(event.page);
      emit(GetMoviesSuccessState(response));
      return;
    } on Exception catch (e) {
      emit(GetMoviesErrorState(e.toString()));
    }
  }
}
