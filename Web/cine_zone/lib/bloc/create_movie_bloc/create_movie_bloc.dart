import 'package:bloc/bloc.dart';
import 'package:cine_zone/models/movie/movie_dto.dart';
import 'package:cine_zone/models/movie/movies_response.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'create_movie_event.dart';
part 'create_movie_state.dart';

class CreateMovieBloc extends Bloc<CreateMovieEvent, CreateMovieState> {
  late MovieRepository movieRepository;
  CreateMovieBloc(this.movieRepository) : super(CreateMovieInitial()) {
    on<CreateMovie>(_doNewMovie);
  }

  Future<void> _doNewMovie(
      CreateMovie event, Emitter<CreateMovieState> emit) async {
    try {
      final register =
          await movieRepository.createMovie(event.movieDto, event.image);
      emit(CreateMovieSuccesState(register));
      return;
    } on Exception catch (e) {
      emit(CreateMovieErrorState(e.toString()));
    }
  }
}
