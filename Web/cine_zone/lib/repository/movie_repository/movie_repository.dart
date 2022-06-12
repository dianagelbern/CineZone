import 'package:cine_zone/models/movie/movies_response.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(String page);
}
