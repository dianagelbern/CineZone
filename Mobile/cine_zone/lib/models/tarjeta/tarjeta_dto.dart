class TarjetaDto {
  TarjetaDto({
    required this.noTarjeta,
    required this.fechaCad,
    required this.titular,
  });
  late final String noTarjeta;
  late final String fechaCad;
  late final String titular;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['no_tarjeta'] = noTarjeta;
    _data['fecha_cad'] = fechaCad;
    _data['titular'] = titular;
    return _data;
  }
}
