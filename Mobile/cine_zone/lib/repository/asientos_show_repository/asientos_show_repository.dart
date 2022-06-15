import 'package:cine_zone/models/asientos_show/asientos_show_response.dart';

abstract class AsientosShowRepository {
  Future<List<AsientoShow>> fetchAsientos(String id);
}
