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
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

class UserRepositoryImpl implements UserRepository {
  final Client _client = Client();

  final AuthRepository authRepository = AuthRepositoryImpl();
  @override
  Future<UserResponse> fetchUserProfile() async {
    var tkn = await Shared.getString(Constant.bearerToken);
    final response = await _client.get(Uri.parse('${Constant.apiBaseUrl}/me'),
        headers: {'Authorization': 'Bearer $tkn'});
    if (response.statusCode == 200) {
      return UserResponse.fromJson(
          json.decode(utf8.decode(response.body.runes.toList())));
    } else {
      throw Exception("Fail to load");
    }
  }

  @override
  Future<LoginResponse> crearRegistro(UserDto dto) async {
    var tkn = await Shared.getString(Constant.bearerToken);

    Map<String, String> headers = {
      "Authorization": "Bearer $tkn",
      "content-type": "application/json"
    };

    final response = await _client.post(
        Uri.parse('${Constant.apiBaseUrl}/auth/register/usuario'),
        headers: headers,
        body: jsonEncode(dto));

    debugPrint(response.statusCode.toString());

    if (response.statusCode == 201) {
      return authRepository
          .login(LoginDto(email: dto.email!, password: dto.password!));
    } else {
      throw Exception("Oops ${response.statusCode}");
    }
  }
}
