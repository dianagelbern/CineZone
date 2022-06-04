import 'package:cine_zone/models/movie/movie_response.dart';

abstract class MovieRepository {
  Future<List<MovieItem>> fetchMovies(String type);

  Future<MovieItem> getMovieById(String id);
}
