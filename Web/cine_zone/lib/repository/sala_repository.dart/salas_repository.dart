import 'package:cine_zone/models/sala/sala_from_cine_response.dart';

abstract class SalaRepository {
  Future<SalasFromCineResponse> getAllSalasFromCine(String page, String cineId);
}
