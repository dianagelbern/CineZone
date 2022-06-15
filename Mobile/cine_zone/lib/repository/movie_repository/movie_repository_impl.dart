import 'dart:convert';

import 'package:cine_zone/models/movie/movie_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:http/http.dart';
import 'dart:convert' show utf8;

class MovieRepositoryImpl extends MovieRepository {
  final Client _client = Client();

  @override
  Future<List<MovieItem>> fetchMovies(String page) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/movie/?page=$page'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .content
          .reversed
          .toList();
    } else {
      throw Exception("Fail to load");
    }
  }

  @override
  Future<MovieItem> getMovieById(String id) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/movie/$id'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return MovieItem.fromJson(
          json.decode(utf8.decode(response.body.runes.toList())));
    } else {
      throw Exception("Fail to load");
    }
  }

  //@override
  /*
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
  */
}
