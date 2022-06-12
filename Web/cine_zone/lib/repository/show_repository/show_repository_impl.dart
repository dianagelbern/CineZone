import 'package:cine_zone/models/show/show_by_sala_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/show_repository/show_repository.dart';
import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart';

class ShowRepositoryImpl extends ShowRepository {
  final Client _client = Client();

  @override
  Future<List<Show>> fetchShowsBySalaAndDate(
      String page, String salaId, String fecha) async {
    var tkn = window.localStorage[Constant.bearerToken];

    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/show/sala/$salaId/date/$fecha'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return ShowsBySalaResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .content
          .toList();
    } else {
      throw Exception(response.statusCode);
    }
  }
}
