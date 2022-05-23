import 'dart:convert';

import 'package:cine_zone/models/auth/login_dto.dart';
import 'package:cine_zone/models/auth/login_response.dart';
import 'package:cine_zone/repository/auth_repository/auth_repository.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/shared.dart';
import 'package:http/http.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    var tkn = await Shared.getToken();

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $tkn"
    };

    final response = await _client.post(
        Uri.parse('${Constant.apiBaseUrl}/auth/login'),
        headers: headers,
        body: jsonEncode(loginDto.toJson()));
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to login');
    }
  }
}
