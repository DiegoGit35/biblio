class Libro {
  late String titulo,
      editorial,
      estadoFisico,
      disponibilidad,
      fechaRegistro,
      autoresanio,
      isbn,
      autores,
      anio,
      idLibro;
  String? fechaBaja;

  Libro(
      {required this.anio,
      required this.titulo,
      required this.editorial,
      required this.estadoFisico,
      required this.disponibilidad,
      required this.fechaRegistro,
      required this.autores,
      required this.isbn,
      required fechaBaja,
      required idLibro});

  factory Libro.fromSqfliteDatabase(Map<String, dynamic> map) {
    return Libro(
        idLibro: map['id_ejemplar'].toString(),
        anio: map['anio'].toString(),
        titulo: map['titulo'] ?? '',
        editorial: map['editorial'] ?? '',
        estadoFisico: map['estado_fisico'] ?? '',
        disponibilidad: map['disponibilidad'] ?? '',
        fechaRegistro: map['fecha_registro'] ?? '',
        autores: map['autores'] ?? '',
        isbn: map['isbn'].toString(),
        fechaBaja: map['fecha_baja'] ?? '');
  }
}
