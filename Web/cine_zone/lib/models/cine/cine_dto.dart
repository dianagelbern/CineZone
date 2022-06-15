class CineDto {
  CineDto({
    required this.nombre,
    required this.direccion,
    required this.latLon,
    required this.numSalas,
    required this.plaza,
  });
  late final String nombre;
  late final String direccion;
  late final String latLon;
  late final int numSalas;
  late final String plaza;

  CineDto.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    direccion = json['direccion'];
    latLon = json['latLon'];
    numSalas = json['numSalas'];
    plaza = json['plaza'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['direccion'] = direccion;
    _data['latLon'] = latLon;
    _data['numSalas'] = numSalas;
    _data['plaza'] = plaza;
    return _data;
  }
}
