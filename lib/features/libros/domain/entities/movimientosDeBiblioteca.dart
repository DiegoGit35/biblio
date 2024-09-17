import 'package:biblio/features/libros/domain/entities/libro.dart';
import 'package:biblio/features/libros/domain/entities/usuario.dart';
import 'package:flutter/foundation.dart';

class MovimientoDeBiblioteca {
  late DateTime fecha;
  late Usuario usuario;
  late Libro libro;
  late bool esDevolucion;

  MovimientoDeBiblioteca({
    required this.usuario,
    required this.libro,
    required this.esDevolucion,
    required this.fecha,
  });

  factory MovimientoDeBiblioteca.fromSqfliteDatabase(Map<String, dynamic> map) {
    final mov = MovimientoDeBiblioteca(
      fecha: DateTime.parse(map['fecha']),
      esDevolucion: map['es_devolucion'] == 1,
      libro: Libro.fromSqfliteDatabase(map), // Mapea los datos del libro
      usuario: Usuario.fromSqfliteDatabase(map), // Mapea los datos del usuario
    );

    print(mov.toString());
    return mov;
  }
}
