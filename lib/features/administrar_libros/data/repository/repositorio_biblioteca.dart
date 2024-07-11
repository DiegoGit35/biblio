// Definición de la clase abstracta RepositorioBiblioteca
import 'package:biblio/features/administrar_libros/domain/entities/libro.dart';
import 'package:biblio/features/administrar_libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:biblio/features/administrar_libros/domain/entities/usuario.dart';

abstract class RepositorioBiblioteca {
  // Método para agregar un libro
  void agregarLibro(Libro nuevoLibro);

  // Método para agregar un usuario
  void agregarUsuario(Usuario nuevoUsuario);

  // Método para obtener todos los libros
  List<Libro> todosLosLibros();

  // Método para obtener todos los usuarios
  List<Usuario> todosLosUsuarios();

  // Método para agregar un movimiento
  void agregarMovimiento(MovimientoDeBiblioteca nuevoMovimiento);

  // Método para obtener todos los libros no devueltos
  List<Libro> todosLosLibrosNoDevueltos();
}
