import 'dart:convert';

import 'package:cine_zone/models/reserva/reserva_item_dto.dart';
import 'package:cine_zone/models/reserva/reservas_response.dart';
import 'package:cine_zone/models/reserva/reservas_dto.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/reserva_repository/reserva_repository_impl.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:http/http.dart';

abstract class ReservaRepository {
  Future<List<Reserva>> fetchReservas(String page);

  Future<Reserva> createReserva(ReservaItemDto dto);
}
