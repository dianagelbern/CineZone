import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/movie/movie_dto.dart';
import 'package:cine_zone/models/movie/movie_response.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:timeago/timeago.dart';

part 'movie_item_event.dart';
part 'movie_item_state.dart';

class MovieItemBloc extends Bloc<MovieItemEvent, MovieItemState> {
  final MovieRepository movieRepository;

  MovieItemBloc(this.movieRepository) : super(MovieItemInitial()) {
    on<MovieItemFetchEvent>(_movie);
  }

  FutureOr<void> _movie(
      MovieItemFetchEvent event, Emitter<MovieItemState> emit) async {
    try {
      final movieItem = await movieRepository.getMovieById(event.id);
      emit(MovieItemfetchedState(movieItem));
      return;
    } on Exception catch (e) {
      emit(MovieItemFetchError(e.toString()));
    }
  }
}
