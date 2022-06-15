class ReservaItemDto {
  ReservaItemDto({
    required this.showId,
    required this.cineId,
    required this.asientoId,
    required this.tarjetaId,
    required this.no_tarjeta,
    required this.fecha_cad,
    required this.titular,
  });
  late final String showId;
  late final String cineId;
  late final String asientoId;
  late final String tarjetaId;
  late final String no_tarjeta;
  late final String fecha_cad;
  late final String titular;

  ReservaItemDto.fromJson(Map<String, dynamic> json) {
    showId = json['showId'];
    cineId = json['cineId'];
    asientoId = json['asientoId'];
    tarjetaId = json['tarjetaId'];
    no_tarjeta = json['no_tarjeta'];
    fecha_cad = json['fecha_cad'];
    titular = json['titular'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['showId'] = showId;
    _data['cineId'] = cineId;
    _data['asientoId'] = asientoId;
    _data['tarjetaId'] = tarjetaId;
    _data['no_tarjeta'] = no_tarjeta;
    _data['fecha_cad'] = fecha_cad;
    _data['titular'] = titular;
    return _data;
  }
}
