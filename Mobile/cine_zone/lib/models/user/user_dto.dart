class UserDto {
  UserDto({
    required this.nombre,
    required this.email,
    required this.password,
    required this.password2,
    required this.telefono,
    required this.fechaNacimiento,
  });
  late final String nombre;
  late final String email;
  late final String password;
  late final String password2;
  late final String telefono;
  late final String fechaNacimiento;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['email'] = email;
    _data['password'] = password;
    _data['password2'] = password2;
    _data['telefono'] = telefono;
    _data['fechaNacimiento'] = fechaNacimiento;
    return _data;
  }
}
