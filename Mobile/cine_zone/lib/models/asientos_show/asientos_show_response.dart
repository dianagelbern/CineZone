class AsientosShowResponse {
  AsientosShowResponse({
    required this.result,
  });
  late final List<AsientoShow> result;

  AsientosShowResponse.fromJson(Map<String, dynamic> json) {
    result =
        List.from(json['result']).map((e) => AsientoShow.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AsientoShow {
  AsientoShow({
    required this.asientoId,
    required this.showId,
    required this.esOcupado,
    required this.fila,
    required this.num,
    required this.salaId,
  });
  late final int asientoId;
  late final int showId;
  late final bool esOcupado;
  late final int fila;
  late final int num;
  late final int salaId;

  AsientoShow.fromJson(Map<String, dynamic> json) {
    asientoId = json['asientoId'];
    showId = json['showId'];
    esOcupado = json['esOcupado'];
    fila = json['fila'];
    num = json['num'];
    salaId = json['salaId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['asientoId'] = asientoId;
    _data['showId'] = showId;
    _data['esOcupado'] = esOcupado;
    _data['fila'] = fila;
    _data['num'] = num;
    _data['salaId'] = salaId;
    return _data;
  }
}
