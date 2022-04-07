import 'package:cine_zone/models/movie_response.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(String type);
}
