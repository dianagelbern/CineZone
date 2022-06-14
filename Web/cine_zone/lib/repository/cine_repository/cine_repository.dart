import 'package:cine_zone/models/cine/cine_dto.dart';
import 'package:cine_zone/models/cine/cine_response.dart';

abstract class CineRepository {
  Future<List<Cine>> fetchCines(String page);

  Future<Cine> createCine(CineDto cineDto);
}
