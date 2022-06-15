import 'dart:convert';

import 'package:cine_zone/models/asientos_show/asientos_show_response.dart';
import 'package:cine_zone/models/error/api_exception.dart';
import 'package:cine_zone/repository/asientos_show_repository/asientos_show_repository.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';

import 'package:http/http.dart';

class AsientosShowRepositoryImpl extends AsientosShowRepository {
  final Client _client = Client();

  @override
  Future<List<AsientoShow>> fetchAsientos(String id) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/asientoShow/show/$id'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return AsientosShowResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .result;
    } else {
      throw ApiErrorResponse.fromJson(jsonDecode(response.body)).mensaje;
    }
  }
}
