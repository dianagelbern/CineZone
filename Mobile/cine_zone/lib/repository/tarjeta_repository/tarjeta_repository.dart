import 'package:cine_zone/models/tarjeta/tarjeta_dto.dart';
import 'package:cine_zone/models/tarjeta/tarjeta_response.dart';

abstract class TarjetaRepository {
  Future<List<Tarjeta>> fetchTarjetas(String page);

  Future<Tarjeta> createTarjeta(TarjetaDto dto);

  Future<void> eliminarTarjeta(String id);
}
