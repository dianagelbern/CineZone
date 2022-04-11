import 'package:cine_zone/models/auth/login_dto.dart';
import 'package:cine_zone/models/auth/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
}
