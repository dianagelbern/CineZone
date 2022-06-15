class UserAdminDto {
  UserAdminDto({
    required this.password,
    required this.password2,
    required this.nombre,
    required this.telefono,
    required this.email,
    required this.fechaNacimiento,
  });
  late final String password;
  late final String password2;
  late final String nombre;
  late final String telefono;
  late final String email;
  late final String fechaNacimiento;

  UserAdminDto.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    password2 = json['password2'];
    nombre = json['nombre'];
    telefono = json['telefono'];
    email = json['email'];
    fechaNacimiento = json['fechaNacimiento'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['password'] = password;
    _data['password2'] = password2;
    _data['nombre'] = nombre;
    _data['telefono'] = telefono;
    _data['email'] = email;
    _data['fechaNacimiento'] = fechaNacimiento;
    return _data;
  }
}
