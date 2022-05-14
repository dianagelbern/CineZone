class ReservasDto {
  ReservasDto({
    required this.id,
    required this.sala,
    required this.butaca,
    required this.movie,
    required this.formato,
    required this.cine,
    required this.email,
    required this.fecha,
    required this.fechaShow,
  });

  late final dynamic id;
  late final String sala;
  late final String butaca;
  late final String movie;
  late final String formato;
  late final String cine;
  late final String email;
  late final String fecha;
  late final String fechaShow;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sala'] = sala;
    _data['butaca'] = butaca;
    _data['movie'] = movie;
    _data['formato'] = formato;
    _data['cine'] = cine;
    _data['email'] = email;
    _data['fecha'] = fecha;
    _data['fechaShow'] = fechaShow;
    return _data;
  }
}
