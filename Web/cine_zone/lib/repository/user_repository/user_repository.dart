import 'package:cine_zone/models/cine/cine_response.dart';
import 'package:cine_zone/models/user/new_user_dto.dart';
import 'package:cine_zone/models/user/user_admin_dto.dart';
import 'package:cine_zone/models/user/user_response.dart';
import 'package:cine_zone/models/user/users_response.dart';

abstract class UserRepository {
  Future<List<User>> fetchUsers(String page);

  Future<UserResponse> fetchUserProfile();

  Future<UserResponse> editUserProfile(NewUserDto dto);

  Future<User> createNewUSer(UserAdminDto dto);
}
