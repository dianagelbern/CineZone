import 'dart:convert';

import 'package:cine_zone/models/movie_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:http/http.dart';

class MovieRepositoryImpl extends MovieRepository {
  final Client _client = Client();

  @override
  Future<List<Movie>> fetchMovies(String type) async {
    final response = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$type?api_key=${Constant.apiKey}'));
    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw Exception('Fail to load movies');
    }
  }

  @override
  Future<List<Movie>> fetchMoviesVideos(String type) async {
    final response = await _client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$type/videos?api_key=${Constant.apiKey}&language=en-US'));

    //https://api.themoviedb.org/3/movie/$type/videos?api_key=${Constant.apiKey}&language=en-US
    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw Exception('Fail to load movies');
    }
  }
}
