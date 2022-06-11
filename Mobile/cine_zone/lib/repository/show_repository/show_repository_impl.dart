import 'dart:convert';

import 'package:cine_zone/models/error/api_exception.dart';
import 'package:cine_zone/models/show/show_by_cine_response.dart';
import 'package:cine_zone/models/show/show_by_movie_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';

import 'package:http/http.dart';

class ShowRepositoryImpl extends ShowRepository {
  final Client _client = Client();

  @override
  Future<List<MovieShow>> fetchShowsByMovie(
      int id, String fecha, String page) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await _client.get(
        Uri.parse(
            '${Constant.apiBaseUrl}/show/movie/$id/date/$fecha?page=$page'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return ShowsByMovieResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .content
          .reversed
          .toList();
    } else {
      print(ApiErrorResponse.fromJson(jsonDecode(response.body)).codigo);
      throw Exception(response.statusCode);

      //throw ApiErrorResponse.fromJson(jsonDecode(response.body)).mensaje;
    }
  }

  @override
  Future<List<CineShow>> fetchShowsByCine(
      int id, String fecha, String page) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await _client.get(
        Uri.parse(
            '${Constant.apiBaseUrl}/show/cine/$id/date/$fecha?page=$page'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return ShowByCineResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .content
          .reversed
          .toList();
    } else {
      throw Exception(response.statusCode);
    }
  }
}
