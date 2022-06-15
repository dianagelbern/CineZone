import 'package:cine_zone/models/cine/cines_response.dart';
import 'package:cine_zone/repository/cine_repository/cine_repository.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';

import 'package:http/http.dart';
import 'dart:convert' show json, utf8;

class CineRepositoryImpl extends CineRepository {
  final Client _client = Client();

  @override
  Future<List<Cine>> fetchCines(String page) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/cine/?page=$page'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return CinesResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .content
          .reversed
          .toList();
    } else {
      throw Exception("Fail to load");
    }
  }
}
