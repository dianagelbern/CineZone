class NewUserDto {
  NewUserDto({
    required this.nombre,
    required this.telefono,
    required this.email,
    required this.fechaNacimiento,
  });
  late final String nombre;
  late final String telefono;
  late final String email;
  late final String fechaNacimiento;

  NewUserDto.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    telefono = json['telefono'];
    email = json['email'];
    fechaNacimiento = json['fechaNacimiento'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['telefono'] = telefono;
    _data['email'] = email;
    _data['fechaNacimiento'] = fechaNacimiento;
    return _data;
  }
}
