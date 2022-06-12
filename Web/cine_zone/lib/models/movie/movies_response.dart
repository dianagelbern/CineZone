class MoviesResponse {
  MoviesResponse({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });
  late final List<Movie> content;
  late final Pageable pageable;
  late final bool last;
  late final int totalPages;
  late final int totalElements;
  late final int size;
  late final int number;
  late final Sort sort;
  late final bool first;
  late final int numberOfElements;
  late final bool empty;

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content']).map((e) => Movie.fromJson(e)).toList();
    pageable = Pageable.fromJson(json['pageable']);
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    number = json['number'];
    sort = Sort.fromJson(json['sort']);
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['content'] = content.map((e) => e.toJson()).toList();
    _data['pageable'] = pageable.toJson();
    _data['last'] = last;
    _data['totalPages'] = totalPages;
    _data['totalElements'] = totalElements;
    _data['size'] = size;
    _data['number'] = number;
    _data['sort'] = sort.toJson();
    _data['first'] = first;
    _data['numberOfElements'] = numberOfElements;
    _data['empty'] = empty;
    return _data;
  }
}

class Movie {
  Movie({
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

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    genero = json['genero'];
    titulo = json['titulo'];
    director = json['director'];
    clasificacion = json['clasificacion'];
    productora = json['productora'];
    sinopsis = json['sinopsis'];
    duracion = json['duracion'];
    imagen = json['imagen'];
    trailer = json['trailer'];
  }

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

class Pageable {
  Pageable({
    required this.sort,
    required this.offset,
    required this.pageNumber,
    required this.pageSize,
    required this.paged,
    required this.unpaged,
  });
  late final Sort sort;
  late final int offset;
  late final int pageNumber;
  late final int pageSize;
  late final bool paged;
  late final bool unpaged;

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = Sort.fromJson(json['sort']);
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sort'] = sort.toJson();
    _data['offset'] = offset;
    _data['pageNumber'] = pageNumber;
    _data['pageSize'] = pageSize;
    _data['paged'] = paged;
    _data['unpaged'] = unpaged;
    return _data;
  }
}

class Sort {
  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });
  late final bool empty;
  late final bool sorted;
  late final bool unsorted;

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    sorted = json['sorted'];
    unsorted = json['unsorted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['empty'] = empty;
    _data['sorted'] = sorted;
    _data['unsorted'] = unsorted;
    return _data;
  }
}
