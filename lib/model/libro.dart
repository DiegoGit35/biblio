class Libro {
  String idEjemplar, editorial, titulo, estadoFisico, disponibilidad, autores;
  final String? fechaRegistro, fechaBaja;
  int isbn, anio;
  int idLibro;

  Libro({
    required this.idLibro,
    required this.idEjemplar,
    required this.anio,
    required this.titulo,
    required this.editorial,
    required this.estadoFisico,
    required this.disponibilidad,
    required this.autores,
    required this.isbn,
    this.fechaRegistro,
    this.fechaBaja,
  });

  factory Libro.fromSqfliteDatabase(Map<String, dynamic> map) => Libro(
        idEjemplar: map['id_ejemplar']?.toString() ?? '',
        idLibro: map['id_libro'] ?? '',
        editorial: map['editorial'] ?? '',
        titulo: map['titulo'] ?? '',
        estadoFisico: map['estado_fisico'] ?? '',
        disponibilidad: map['disponibilidad'] ?? '',
        autores: map['autores'] ?? '',
        isbn: map['ISBN']?.toInt() ?? 0,
        anio: map['anio']?.toInt() ?? 0,
        fechaRegistro: map['fecha_registro'] ?? '',
        fechaBaja: map['fecha_baja'] ?? '',
      );
}
