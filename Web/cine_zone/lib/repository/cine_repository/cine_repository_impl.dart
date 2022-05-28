import 'dart:convert';
import 'dart:html';

import 'package:cine_zone/models/cine/cine_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:http/http.dart';

class CineRepositoryImpl extends CineRepository {
  final Client _client = Client();

  @override
  Future<CinesResponse> fetchCines(String page) async {
    //var tkn = await Shared.getToken();

    var tkn = window.localStorage[Constant.bearerToken];

    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/cine/?page=0'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return CinesResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }
}
