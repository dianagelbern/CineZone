part of 'create_movie_bloc.dart';

abstract class CreateMovieEvent extends Equatable {
  const CreateMovieEvent();

  @override
  List<Object> get props => [];
}

class CreateMovie extends CreateMovieEvent {
  final MovieDto movieDto;
  final String image;

  const CreateMovie(this.movieDto, this.image);

  @override
  List<Object> get props => [];
}
