import 'package:cine_zone/models/user/user_admin_dto.dart';
import 'package:cine_zone/models/user/user_response.dart';
import 'package:cine_zone/models/user/new_user_dto.dart';
import 'package:cine_zone/models/user/users_response.dart';
import 'package:cine_zone/repository/constants.dart';
import 'package:cine_zone/repository/user_repository/user_repository.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:html';

class UserRepositoryImpl extends UserRepository {
  final Client _client = Client();

//Trae a la lista de usuarios con rol usuario
  @override
  Future<List<User>> fetchUsers(String page) async {
    var tkn = window.localStorage[Constant.bearerToken];

    final response = await _client.get(
        Uri.parse('${Constant.apiBaseUrl}/usuarios/?page=$page'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return UsersResponse.fromJson(
              json.decode(utf8.decode(response.body.runes.toList())))
          .content
          .toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

//Permite editar el perfil del admin
  @override
  Future<UserResponse> editUserProfile(NewUserDto dto) async {
    var tkn = window.localStorage[Constant.bearerToken];

    Map<String, String> headers = {
      "Authorization": "Bearer $tkn",
      "content-type": "application/json"
    };

    final response = await _client.put(
        Uri.parse('${Constant.apiBaseUrl}/usuario/'),
        headers: headers,
        body: jsonEncode(dto));

    if (response.statusCode == 201) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }

//Trae los datos del administrador
  @override
  Future<UserResponse> fetchUserProfile() async {
    var tkn = window.localStorage[Constant.bearerToken];

    final response = await _client.get(Uri.parse('${Constant.apiBaseUrl}/me'),
        headers: {'Authorization': 'Bearer $tkn'});

    if (response.statusCode == 200) {
      return UserResponse.fromJson(
          json.decode(utf8.decode(response.body.runes.toList())));
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  Future<User> createNewUSer(UserAdminDto dto) async {
    var tkn = window.localStorage[Constant.bearerToken];

    Map<String, String> headers = {
      "Authorization": "Bearer $tkn",
      "content-type": "application/json"
    };

    final response = await _client.post(
        Uri.parse('${Constant.apiBaseUrl}/auth/register/admin'),
        headers: headers,
        body: jsonEncode(dto));

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Oops ${response.statusCode}");
    }
  }
}
