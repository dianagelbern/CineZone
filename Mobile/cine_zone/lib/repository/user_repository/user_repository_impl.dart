import 'dart:convert';

import 'package:cine_zone/models/auth/login_dto.dart';
import 'package:cine_zone/models/auth/login_response.dart';
import 'package:cine_zone/models/user/user_dto.dart';
import 'package:cine_zone/models/user/user_response.dart';
import 'package:cine_zone/repository/auth_repository/auth_repository.dart';
import 'package:cine_zone/repository/auth_repository/login_repository_impl.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthRepository authRepository = AuthRepositoryImpl();
  @override
  Future<UserResponse> fetchUserProfile() async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await http.get(Uri.parse('${Constant.apiBaseUrl}/me'),
        headers: {'Authorization': 'Bearer $tkn'});
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Fail to load");
    }
  }

  @override
  Future<LoginResponse> crearRegistro(UserDto dto, String image) async {
    var tkn = await Shared.getString(Constant.bearerToken);

    final body = jsonEncode({
      'nombre': dto.nombre,
      'email': dto.email,
      'password': dto.password,
      'password2': dto.password2,
      'telefono': dto.telefono,
      'fechaNacimiento': dto.fechaNacimiento
    });

    final request = http.MultipartRequest(
        'POST', Uri.parse('${Constant.apiBaseUrl}/auth/register/usuario'))
      ..files.add(http.MultipartFile.fromString('body', body,
          contentType: MediaType('application', 'json')))
      ..files.add(await http.MultipartFile.fromPath('file', image,
          contentType: MediaType('image', 'jpg')))
      ..headers.addAll({"Authorization": "Bearer $tkn"});

    final response = await request.send();
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 201) {
      return authRepository
          .login(LoginDto(email: dto.email, password: dto.password));
    } else {
      throw Exception("Oops ${response.statusCode}");
    }
  }
}
