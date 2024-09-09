import 'package:biblio/features/administrar_libros/domain/entities/editorial.dart';
import 'package:equatable/equatable.dart';

class LibroEntity extends Equatable {
  const LibroEntity(
      {required this.idLibro,
      required this.titulo,
      required this.editorial,
      required this.estadoFisico,
      required this.disponibilidad,
      required this.fechaRegistro,
      required this.autores,
      required this.anio,
      required this.isbn});
  final String titulo,
      editorial,
      estadoFisico,
      disponibilidad,
      fechaRegistro,
      autores,
      anio,
      isbn;
  final int idLibro;
  // final Editorial editorial;

  @override
  // TODO: implement props
  List<Object?> get props => [
        idLibro,
        titulo,
        editorial,
        estadoFisico,
        disponibilidad,
        fechaRegistro,
        autores,
        anio,
        isbn,
      ];
}

class LibroUpdate extends Equatable {
  const LibroUpdate({
    required this.titulo,
    required this.editorial,
    required this.estadoFisico,
    required this.disponibilidad,
    // required this.fechaRegistro,
    required this.autores,
    required this.anio,
    // required this.isbn
  });
  final String titulo,
      editorial,
      estadoFisico,
      disponibilidad,
      // fechaRegistro,
      autores,
      anio;
  // final Editorial editorial;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
