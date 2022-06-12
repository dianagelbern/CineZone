import 'package:cine_zone/models/movie/movies_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:html';

class MovieRepositoryImpl extends MovieRepository {
  final Client _client = Client();

  @override
  Future<List<Movie>> fetchMovies(String page) async {
    var tkn = window.localStorage[Constant.bearerToken];

    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/movie/?page=$page'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .content
          .toList();
    } else {
      throw Exception(response.statusCode);
    }
  }
}
