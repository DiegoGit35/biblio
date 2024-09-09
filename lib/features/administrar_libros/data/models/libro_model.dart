import 'package:biblio/features/administrar_libros/domain/entities/libro_entity.dart';

class LibroModel extends LibroEntity {
  const LibroModel(
      {required super.idLibro,
      required super.titulo,
      required super.editorial,
      required super.estadoFisico,
      required super.disponibilidad,
      required super.fechaRegistro,
      required super.autores,
      required super.anio,
      required super.isbn});

  factory LibroModel.fromSqfliteDatabase(Map<String, dynamic> map) {
    return LibroModel(
        idLibro: map['id_ejemplar'],
        anio: map['anio'].toString(),
        titulo: map['titulo'] ?? '',
        editorial: map['editorial'] ?? '',
        estadoFisico: map['estado_fisico'] ?? '',
        disponibilidad: map['disponibilidad'] ?? '',
        fechaRegistro: map['fecha_registro'] ?? '',
        autores: map['autores'] ?? '',
        isbn: map['isbn'].toString());
    // fechaBaja: map['fecha_baja'] ?? '')
  }
}
