import 'package:cine_zone/models/show/show_by_cine_response.dart';
import 'package:cine_zone/models/show/show_by_movie_response.dart';

abstract class ShowRepository {
  Future<List<MovieShow>> fetchShowsByMovie(int id, String fecha, String page);

  Future<List<CineShow>> fetchShowsByCine(int id, String fecha, String page);
}
