import 'package:timeago/timeago.dart';

class UserResponse {
  UserResponse({
    required this.id,
    required this.email,
    required this.nombre,
    required this.telefono,
    required this.fechaNacimiento,
    required this.password,
    required this.password2,
    required this.role,
  });
  late final String? id;
  late final String? email;
  late final String? nombre;
  late final String? telefono;
  late final String? fechaNacimiento;
  late final String? password;
  late final String? password2;
  late final String? role;

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    nombre = json['nombre'];
    telefono = json['telefono'];
    fechaNacimiento = json['fechaNacimiento'];
    password = json['password'];
    password2 = json['password2'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['nombre'] = nombre;
    _data['telefono'] = telefono;
    _data['fechaNacimiento'] = fechaNacimiento;
    _data['password'] = password;
    _data['password2'] = password2;
    _data['role'] = role;
    return _data;
  }
}
