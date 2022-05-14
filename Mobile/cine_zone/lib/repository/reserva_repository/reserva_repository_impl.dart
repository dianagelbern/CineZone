import 'dart:convert';

import 'package:cine_zone/models/reserva/reservas_dto.dart';
import 'package:cine_zone/models/reserva/reservas_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/reserva_repository/reserva_repository.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:http/http.dart';

class ReservaRepositoryImpl extends ReservaRepository {
  final Client _client = Client();
  //final ReservaRepository reservaRepository = ReservaRepositoryImpl();

  /*
  @override
  Future<Reserva> createReserva(ReservasDto dto) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    Map<String, String> headers = {
      "Authorization": "Bearer $tkn",
      "content-type": "application/json"
    };

    final response = await _client.post(
        Uri.parse('${Constant.apiBaseUrl}/reserva'),
        headers: headers,
        body: jsonEncode(dto));

    if (response.statusCode == 201) {
      return reservaRepository.createReserva(ReservasDto(
          id: dto.id,
          sala: dto.butaca,
          butaca: dto.butaca,
          movie: dto.movie,
          formato: dto.formato,
          cine: dto.cine,
          email: dto.email,
          fecha: dto.fecha,
          fechaShow: dto.fechaShow));
    } else {
      throw Exception("Oops ${response.statusCode}");
    }
  }
  */

  @override
  Future<List<Reserva>> fetchReservas(String page) async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/reserva/?page=0'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return ReservasResponse.fromJson(json.decode(response.body))
          .content
          .reversed
          .toList();
    } else {
      throw Exception("Fail to load");
    }
  }

  @override
  Future<Reserva> createReserva(ReservasDto dto) {
    // TODO: implement createReserva
    throw UnimplementedError();
  }
}
