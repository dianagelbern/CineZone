class ApiErrorResponse {
  ApiErrorResponse({
    required this.estado,
    required this.codigo,
    required this.mensaje,
    required this.ruta,
    required this.fecha,
  });
  late final String estado;
  late final dynamic codigo;
  late final String mensaje;
  late final String ruta;
  late final String fecha;

  ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    estado = json['estado'];
    codigo = json['codigo'];
    mensaje = json['mensaje'];
    ruta = json['ruta'];
    fecha = json['fecha'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['estado'] = estado;
    _data['codigo'] = codigo;
    _data['mensaje'] = mensaje;
    _data['ruta'] = ruta;
    _data['fecha'] = fecha;
    return _data;
  }
}
