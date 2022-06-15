class ShowByCineResponse {
  ShowByCineResponse({
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
  late final List<CineShow> content;
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

  ShowByCineResponse.fromJson(Map<String, dynamic> json) {
    content =
        List.from(json['content']).map((e) => CineShow.fromJson(e)).toList();
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

class CineShow {
  CineShow({
    required this.id,
    required this.movieImagen,
    required this.movieTitulo,
    required this.salaNombre,
    required this.formato,
    required this.fecha,
    required this.hora,
    required this.nombreCine,
    required this.idCine,
    required this.idMovie,
  });
  late final int id;
  late final String movieImagen;
  late final String movieTitulo;
  late final String salaNombre;
  late final String formato;
  late final String fecha;
  late final String hora;
  late final String nombreCine;
  late final int idCine;
  late final int idMovie;

  CineShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    movieImagen = json['movieImagen'];
    movieTitulo = json['movieTitulo'];
    salaNombre = json['salaNombre'];
    formato = json['formato'];
    fecha = json['fecha'];
    hora = json['hora'];
    nombreCine = json['nombreCine'];
    idCine = json['idCine'];
    idMovie = json['idMovie'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['movieImagen'] = movieImagen;
    _data['movieTitulo'] = movieTitulo;
    _data['salaNombre'] = salaNombre;
    _data['formato'] = formato;
    _data['fecha'] = fecha;
    _data['hora'] = hora;
    _data['nombreCine'] = nombreCine;
    _data['idCine'] = idCine;
    _data['idMovie'] = idMovie;
    return _data;
  }
}

class Pageable {
  Pageable({
    required this.sort,
    required this.offset,
    required this.pageSize,
    required this.pageNumber,
    required this.unpaged,
    required this.paged,
  });
  late final Sort sort;
  late final int offset;
  late final int pageSize;
  late final int pageNumber;
  late final bool unpaged;
  late final bool paged;

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = Sort.fromJson(json['sort']);
    offset = json['offset'];
    pageSize = json['pageSize'];
    pageNumber = json['pageNumber'];
    unpaged = json['unpaged'];
    paged = json['paged'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sort'] = sort.toJson();
    _data['offset'] = offset;
    _data['pageSize'] = pageSize;
    _data['pageNumber'] = pageNumber;
    _data['unpaged'] = unpaged;
    _data['paged'] = paged;
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
