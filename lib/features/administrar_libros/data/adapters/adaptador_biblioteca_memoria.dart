import 'package:biblio/features/administrar_libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/administrar_libros/domain/entities/libro.dart';
import 'package:biblio/features/administrar_libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:biblio/features/administrar_libros/domain/entities/usuario.dart';

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
  List<Libro> todosLosLibrosNoDevueltos() {
    List<Libro> librosNoDevueltos = [];
    for (var movimiento in _movimientos) {
      if (!movimiento.esdevolucion) {
        librosNoDevueltos.add(movimiento.libro);
      }
    }
    return librosNoDevueltos;
  }
}
