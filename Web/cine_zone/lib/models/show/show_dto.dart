class ShowDto {
  ShowDto({
    required this.idMovie,
    required this.idCine,
    required this.idSala,
    required this.fecha,
    required this.hora,
    required this.formato,
    required this.idioma,
  });
  late final int idMovie;
  late final int idCine;
  late final int idSala;
  late final String fecha;
  late final String hora;
  late final String formato;
  late final String idioma;

  ShowDto.fromJson(Map<String, dynamic> json) {
    idMovie = json['idMovie'];
    idCine = json['idCine'];
    idSala = json['idSala'];
    fecha = json['fecha'];
    hora = json['hora'];
    formato = json['formato'];
    idioma = json['idioma'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['idMovie'] = idMovie;
    _data['idCine'] = idCine;
    _data['idSala'] = idSala;
    _data['fecha'] = fecha;
    _data['hora'] = hora;
    _data['formato'] = formato;
    _data['idioma'] = idioma;
    return _data;
  }
}
