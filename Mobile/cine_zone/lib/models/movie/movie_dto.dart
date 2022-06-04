class MovieItem {
  MovieItem({
    required this.id,
    required this.genero,
    required this.titulo,
    required this.director,
    required this.clasificacion,
    required this.productora,
    required this.sinopsis,
    required this.duracion,
    required this.imagen,
    required this.trailer,
  });
  late final int id;
  late final String genero;
  late final String titulo;
  late final String director;
  late final String clasificacion;
  late final String productora;
  late final String sinopsis;
  late final int duracion;
  late final String imagen;
  late final String trailer;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['genero'] = genero;
    _data['titulo'] = titulo;
    _data['director'] = director;
    _data['clasificacion'] = clasificacion;
    _data['productora'] = productora;
    _data['sinopsis'] = sinopsis;
    _data['duracion'] = duracion;
    _data['imagen'] = imagen;
    _data['trailer'] = trailer;
    return _data;
  }
}
