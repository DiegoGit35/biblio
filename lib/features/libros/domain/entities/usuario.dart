class Usuario {
  final String dni, direccion, telefono, nombre, apellido, email;
  String? fechaBaja, codUsuario;

  Usuario({
    this.codUsuario,
    required this.dni,
    required this.direccion,
    required this.telefono,
    required this.nombre,
    required this.apellido,
    required this.email,
  });

  factory Usuario.fromSqfliteDatabase(Map<String, dynamic> map) {
    return Usuario(
      dni: map['dni'].toString(),
      direccion: map['direccion'] ?? '',
      telefono: map['telefono'].toString(),
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      email: map['email'] ?? '',
      // fechaRegistro: map['fecha_registro'] ?? '',
      // fechaBaja: map['fecha_baja'] ?? ''
    );
  }
}
