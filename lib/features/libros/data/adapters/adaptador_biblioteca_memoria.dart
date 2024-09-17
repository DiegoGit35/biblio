import 'package:biblio/features/libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/libros/domain/entities/libro.dart';
import 'package:biblio/features/libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:biblio/features/libros/domain/entities/usuario.dart';

class AdaptadorBibliotecaMemoria implements RepositorioBiblioteca {
  List<Libro> _libros = [];
  List<Usuario> _usuarios = [];
  List<MovimientoDeBiblioteca> _movimientos = [];

  @override
  void agregarLibro(Libro nuevoLibro) {
    _libros.add(nuevoLibro);
  }

  @override
  void agregarUsuario(Usuario nuevoUsuario) {
    _usuarios.add(nuevoUsuario);
  }

  @override
  Future<List<Libro>> todosLosLibros() async {
    return List.from(_libros);
  }

  @override
  Future<List<Usuario>> todosLosUsuarios() async {
    return List.from(_usuarios);
  }

  @override
  void agregarMovimiento(MovimientoDeBiblioteca nuevoMovimiento) {
    _movimientos.add(nuevoMovimiento);
  }

  @override
  Future<List<Libro>> todosLosLibrosNoDevueltos() async {
    List<Libro> librosNoDevueltos = [];
    for (var movimiento in _movimientos) {
      if (!movimiento.esDevolucion) {
        librosNoDevueltos.add(movimiento.libro);
      }
    }
    return librosNoDevueltos;
  }

  @override
  Future<List<MovimientoDeBiblioteca>> todosLosMovimientos() async {
    return List.from(_movimientos);
  }

  @override
  Future<List<Libro>> librosDisponibles() async {
    List<Libro> disponibles =
        _libros.where((libro) => libro.disponibilidad == 'Disponible').toList();
    return disponibles;
  }

  @override
  void devolver(MovimientoDeBiblioteca movimiento) {
    _movimientos.add(MovimientoDeBiblioteca(
      usuario: movimiento.usuario,
      libro: movimiento.libro,
      esDevolucion: true,
      fecha: movimiento.fecha,
    ));
    movimiento.libro.disponibilidad = 'Disponible';
  }

  @override
  Future<List<MovimientoDeBiblioteca>> movimientosPrestamos() async {
    List<MovimientoDeBiblioteca> prestamos =
        _movimientos.where((movimiento) => !movimiento.esDevolucion).toList();
    return prestamos;
  }
}
