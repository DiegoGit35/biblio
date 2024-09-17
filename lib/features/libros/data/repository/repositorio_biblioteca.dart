// Definición de la clase abstracta RepositorioBiblioteca
import 'package:biblio/features/libros/domain/entities/libro.dart';
import 'package:biblio/features/libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:biblio/features/libros/domain/entities/usuario.dart';

abstract class RepositorioBiblioteca {
  // Método para agregar un libro
  void agregarLibro(Libro nuevoLibro);

  // Método para agregar un usuario
  void agregarUsuario(Usuario nuevoUsuario);

  // Método para obtener todos los libros
  Future<List<Libro>> todosLosLibros();

  // Método para obtener todos los usuarios
  Future<List<Usuario>> todosLosUsuarios();

  // Método para agregar un movimiento
  void agregarMovimiento(MovimientoDeBiblioteca nuevoMovimiento);

  // Método para obtener todos los libros no devueltos
  Future<List<Libro>> todosLosLibrosNoDevueltos();

  Future<List<MovimientoDeBiblioteca>> todosLosMovimientos();

  Future<List<Libro>> librosDisponibles();

  void devolver(MovimientoDeBiblioteca movimiento) {}

  Future<List<MovimientoDeBiblioteca>>? movimientosPrestamos() {}
}
