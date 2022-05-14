import 'dart:convert';

import 'package:cine_zone/models/tarjeta/tarjeta_response.dart';
import 'package:cine_zone/models/tarjeta/tarjeta_dto.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:cine_zone/repository/tarjeta_repository/tarjeta_repository.dart';
import 'package:http/http.dart';

class TarjetaRepositoryImpl extends TarjetaRepository {
  final Client _client = Client();
  //final TarjetaRepository tarjetaRepository = TarjetaRepositoryImpl();

  /*
  @override
  Future<Tarjeta> createTarjeta(TarjetaDto dto) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    Map<String, String> headers = {
      "Authorization": "Bearer $tkn",
      "content-type": "application/json"
    };

    final response = await _client.post(
        Uri.parse('${Constant.apiBaseUrl}/tarjeta/'),
        headers: headers,
        body: jsonEncode(dto));

    if (response.statusCode == 201) {
      return tarjetaRepository.createTarjeta(TarjetaDto(
          noTarjeta: dto.noTarjeta,
          fechaCad: dto.fechaCad,
          titular: dto.titular));
    } else {
      throw Exception("Oops ${response.statusCode}");
    }
  }
  */

  @override
  Future<List<Tarjeta>> fetchTarjetas(String page) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/tarjeta/?page=0'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return TarjetaResponse.fromJson(json.decode(response.body))
          .content
          .reversed
          .toList();
    } else {
      throw Exception("Fail to load");
    }
  }

  @override
  Future<Tarjeta> createTarjeta(TarjetaDto dto) {
    // TODO: implement createTarjeta
    throw UnimplementedError();
  }
}
