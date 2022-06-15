class MovieDto {
  MovieDto({
    required this.genero,
    required this.titulo,
    required this.director,
    required this.clasificacion,
    required this.productora,
    required this.sinopsis,
    required this.duracion,
  });
  late final String genero;
  late final String titulo;
  late final String director;
  late final String clasificacion;
  late final String productora;
  late final String sinopsis;
  late final int duracion;

  MovieDto.fromJson(Map<String, dynamic> json) {
    genero = json['genero'];
    titulo = json['titulo'];
    director = json['director'];
    clasificacion = json['clasificacion'];
    productora = json['productora'];
    sinopsis = json['sinopsis'];
    duracion = json['duracion'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['genero'] = genero;
    _data['titulo'] = titulo;
    _data['director'] = director;
    _data['clasificacion'] = clasificacion;
    _data['productora'] = productora;
    _data['sinopsis'] = sinopsis;
    _data['duracion'] = duracion;
    return _data;
  }
}
