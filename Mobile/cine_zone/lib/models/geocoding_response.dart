class GeocodingResponse {
  GeocodingResponse({
    required this.results,
    required this.status,
  });
  late final List<Results> results;
  late final String status;

  GeocodingResponse.fromJson(Map<String, dynamic> json) {
    results =
        List.from(json['results']).map((e) => Results.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['results'] = results.map((e) => e.toJson()).toList();
    _data['status'] = status;
    return _data;
  }
}

class Results {
  Results({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.types,
  });
  late final List<AddressComponents> addressComponents;
  late final String formattedAddress;
  late final Geometry geometry;
  late final String placeId;
  late final List<String> types;

  Results.fromJson(Map<String, dynamic> json) {
    addressComponents = List.from(json['address_components'])
        .map((e) => AddressComponents.fromJson(e))
        .toList();
    formattedAddress = json['formatted_address'];
    geometry = Geometry.fromJson(json['geometry']);
    placeId = json['place_id'];
    types = List.castFrom<dynamic, String>(json['types']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address_components'] =
        addressComponents.map((e) => e.toJson()).toList();
    _data['formatted_address'] = formattedAddress;
    _data['geometry'] = geometry.toJson();
    _data['place_id'] = placeId;
    _data['types'] = types;
    return _data;
  }
}

class AddressComponents {
  AddressComponents({
    required this.longName,
    required this.shortName,
    required this.types,
  });
  late final String longName;
  late final String shortName;
  late final List<String> types;

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = List.castFrom<dynamic, String>(json['types']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['long_name'] = longName;
    _data['short_name'] = shortName;
    _data['types'] = types;
    return _data;
  }
}

class Geometry {
  Geometry({
    required this.bounds,
    required this.location,
    required this.locationType,
    required this.viewport,
  });
  late final Bounds bounds;
  late final Location location;
  late final String locationType;
  late final Viewport viewport;

  Geometry.fromJson(Map<String, dynamic> json) {
    bounds = Bounds.fromJson(json['bounds']);
    location = Location.fromJson(json['location']);
    locationType = json['location_type'];
    viewport = Viewport.fromJson(json['viewport']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bounds'] = bounds.toJson();
    _data['location'] = location.toJson();
    _data['location_type'] = locationType;
    _data['viewport'] = viewport.toJson();
    return _data;
  }
}

class Bounds {
  Bounds({
    required this.northeast,
    required this.southwest,
  });
  late final Northeast northeast;
  late final Southwest southwest;

  Bounds.fromJson(Map<String, dynamic> json) {
    northeast = Northeast.fromJson(json['northeast']);
    southwest = Southwest.fromJson(json['southwest']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['northeast'] = northeast.toJson();
    _data['southwest'] = southwest.toJson();
    return _data;
  }
}

class Northeast {
  Northeast({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Southwest {
  Southwest({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Southwest.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });
  late final Northeast northeast;
  late final Southwest southwest;

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = Northeast.fromJson(json['northeast']);
    southwest = Southwest.fromJson(json['southwest']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['northeast'] = northeast.toJson();
    _data['southwest'] = southwest.toJson();
    return _data;
  }
}
