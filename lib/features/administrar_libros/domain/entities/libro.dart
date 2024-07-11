class Libro {
  late String anio,
      titulo,
      editorial,
      estadoFisico,
      disponibilidad,
      fechaRegistro,
      autores,
      isbn;
  String? fechaBaja, idLibro;

  Libro(
      {required this.anio,
      required this.titulo,
      required this.editorial,
      required this.estadoFisico,
      required this.disponibilidad,
      required this.fechaRegistro,
      required this.autores,
      required this.isbn,
      required fechaBaja});

  factory Libro.fromSqfliteDatabase(Map<String, dynamic> map) => Libro(
      anio: map['anio'] ?? '',
      titulo: map['titulo'] ?? '',
      editorial: map['editorial'] ?? '',
      estadoFisico: map['estado_fisico'] ?? '',
      disponibilidad: map['disponibilidad'] ?? '',
      fechaRegistro: map['fecha_registro'] ?? '',
      autores: map['autores'] ?? '',
      isbn: map['isbn']?.toInt() ?? 0,
      fechaBaja: map['fecha_baja']);
}
