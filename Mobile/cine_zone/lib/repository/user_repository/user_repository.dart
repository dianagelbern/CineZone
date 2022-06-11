import 'package:cine_zone/models/auth/login_response.dart';
import 'package:cine_zone/models/user/new_user_dto.dart';
import 'package:cine_zone/models/user/user_dto.dart';
import 'package:cine_zone/models/user/user_response.dart';

abstract class UserRepository {
  Future<UserResponse> fetchUserProfile();

  Future<LoginResponse> crearRegistro(UserDto dto);

  Future<UserResponse> editUserProfile(NewUserDto dto);
}
