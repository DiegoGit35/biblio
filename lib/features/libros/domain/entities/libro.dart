class Libro {
  late String? nombre,
      editorial,
      estadoFisico,
      disponibilidad,
      fechaRegistro,
      autores,
      anioPublicacion,
      isbn,
      idLibro;
  String? fechaBaja;

  Libro(
      {required this.anioPublicacion,
      required this.nombre,
      required this.editorial,
      this.estadoFisico,
      this.disponibilidad,
      this.fechaRegistro,
      this.autores,
      required this.isbn,
      fechaBaja,
      this.idLibro});

  factory Libro.fromSqfliteDatabase(Map<String, dynamic> map) {
    return Libro(
        idLibro: map['id_ejemplar'].toString(),
        anioPublicacion: map['anio'].toString(),
        nombre: map['titulo'] ?? '',
        editorial: map['editorial'] ?? '',
        estadoFisico: map['estado_fisico'] ?? '',
        disponibilidad: map['disponibilidad'] ?? '',
        fechaRegistro: map['fecha_registro'] ?? '',
        autores: map['autores'] ?? '',
        isbn: map['isbn'].toString(),
        fechaBaja: map['fecha_baja'] ?? '');
  }
}
