import 'package:cine_zone/models/cine/cine_response.dart';

abstract class CineRepository {
  Future<CinesResponse> fetchCines(String page);
}
