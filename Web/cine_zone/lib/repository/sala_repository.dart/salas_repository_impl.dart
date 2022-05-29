import 'dart:convert';
import 'dart:html';

import 'package:cine_zone/models/sala/sala_from_cine_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:http/http.dart';

import 'package:cine_zone/repository/sala_repository.dart/salas_repository.dart';

class SalaRepositoryImpl extends SalaRepository {
  final Client _client = Client();

  @override
  Future<SalasFromCineResponse> getAllSalasFromCine(
      String page, String cineId) async {
    var tkn = window.localStorage[Constant.bearerToken];

    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/sala/$cineId/cineSala'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return SalasFromCineResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }
}
