import 'dart:typed_data';

import 'package:cine_zone/models/movie/movie_dto.dart';
import 'package:cine_zone/models/movie/movies_response.dart';
import 'package:image_picker/image_picker.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies(String page);

  Future<Movie> createMovie(MovieDto dto, XFile bytesData);
}
