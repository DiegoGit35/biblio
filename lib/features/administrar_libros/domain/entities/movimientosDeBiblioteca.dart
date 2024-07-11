import 'package:biblio/features/administrar_libros/domain/entities/libro.dart';
import 'package:biblio/features/administrar_libros/domain/entities/usuario.dart';

class MovimientoDeBiblioteca {
  late DateTime fecha;
  late Usuario usuario;
  late Libro libro;
  late bool esdevolucion;

  MovimientoDeBiblioteca(
      this.fecha, this.usuario, this.libro, this.esdevolucion);
}
