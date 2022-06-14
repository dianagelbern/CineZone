import 'package:cine_zone/models/show/show_by_sala_response.dart';
import 'package:cine_zone/models/show/show_dto.dart';

abstract class ShowRepository {
  Future<List<Show>> fetchShowsBySalaAndDate(
      String page, String salaId, String fecha);

  Future<Show> createShow(ShowDto showDto);
}
