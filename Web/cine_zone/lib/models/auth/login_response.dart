class LoginResponse {
  LoginResponse({
    required this.email,
    required this.nombre,
    required this.telefono,
    required this.fechaNacimiento,
    required this.role,
    required this.token,
  });
  late final String email;
  late final String nombre;
  late final String telefono;
  late final String fechaNacimiento;
  late final String role;
  late final String token;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    nombre = json['nombre'];
    telefono = json['telefono'];
    fechaNacimiento = json['fechaNacimiento'];
    role = json['role'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['nombre'] = nombre;
    _data['telefono'] = telefono;
    _data['fechaNacimiento'] = fechaNacimiento;
    _data['role'] = role;
    _data['token'] = token;
    return _data;
  }
}
