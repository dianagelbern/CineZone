import 'dart:convert';
import 'dart:html';

import 'package:cine_zone/models/cine/cine_dto.dart';
import 'package:cine_zone/models/cine/cine_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:http/http.dart';

class CineRepositoryImpl extends CineRepository {
  final Client _client = Client();

  @override
  Future<List<Cine>> fetchCines(String page) async {
    //var tkn = await Shared.getToken();

    var tkn = window.localStorage[Constant.bearerToken];

    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/cine/?page=$page'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return CinesResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .content
          .toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<Cine> createCine(CineDto cineDto) async {
    var tkn = window.localStorage[Constant.bearerToken];

    Map<String, String> headers = {
      "Authorization": "Bearer $tkn",
      "content-type": "application/json"
    };

    final response = await _client.post(
        Uri.parse('${Constant.apiBaseUrl}/cine/'),
        headers: headers,
        body: jsonEncode(cineDto));

    if (response.statusCode == 201) {
      return Cine.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Oops ${response.statusCode}");
    }
  }
}
