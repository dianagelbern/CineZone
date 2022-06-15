class ShowsBySalaResponse {
  ShowsBySalaResponse({
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
  late final List<Show> content;
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

  ShowsBySalaResponse.fromJson(Map<String, dynamic> json) {
    content = List.from(json['content']).map((e) => Show.fromJson(e)).toList();
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

class Show {
  Show({
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

  Show.fromJson(Map<String, dynamic> json) {
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
