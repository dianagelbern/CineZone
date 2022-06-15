import 'dart:typed_data';

import 'package:cine_zone/models/error/api_error.dart';
import 'package:cine_zone/models/movie/message_dto.dart';
import 'package:cine_zone/models/movie/movie_dto.dart';
import 'package:cine_zone/models/movie/movies_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/movie_repository/movie_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:html';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MovieRepositoryImpl extends MovieRepository {
  final Client _client = Client();

  @override
  Future<List<Movie>> fetchMovies(String page) async {
    var tkn = window.localStorage[Constant.bearerToken];

    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/movie/?page=$page'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return MoviesResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .content
          .toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<Movie> createMovie(MovieDto dto, XFile image) async {
    var tkn = window.localStorage[Constant.bearerToken];
    //Uint8List _bytesData = Base64Decoder().convert(image.path);
    //List<int> _selectedFile = _bytesData;

    final request = http.MultipartRequest(
        'POST', Uri.parse('${Constant.apiBaseUrl}/movie/'))
      ..files.add(http.MultipartFile.fromString('movie', jsonEncode(dto),
          contentType: MediaType('application', 'json')))
      ..files.add(http.MultipartFile.fromBytes(
          'image',
          await image.readAsBytes().then((value) {
            return value.cast();
          }),
          filename: image.name))
      ..headers.addAll({"Authorization": "Bearer $tkn"});

/*     final request = http.MultipartRequest(
        'POST', Uri.parse('${Constant.apiBaseUrl}/movie/'))
      ..files.add(http.MultipartFile.fromString('movie', jsonEncode(dto),
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromBytes('file', _selectedFile,
          contentType: MediaType('image', image.mimeType.toString())))
      ..headers.addAll({"Authorization": "Bearer $tkn"});
 */
    final response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 201) {
      return Movie.fromJson(jsonDecode(await response.stream.bytesToString()));
    } else {
      response.stream.transform(utf8.decoder).listen((value) {
        debugPrint(
            ApiErrorResponse.fromJson(jsonDecode(value)).toJson().toString());
      });

      throw Exception(response.statusCode);
    }
  }
}
