import 'package:cine_zone/models/cine/cines_response.dart';

abstract class CineRepository {
  Future<List<Cine>> fetchCines(String page);
}
