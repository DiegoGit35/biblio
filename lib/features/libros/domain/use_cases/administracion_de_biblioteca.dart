import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_memoria.dart';
import 'package:biblio/features/libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/libros/domain/entities/libro.dart';
import 'package:biblio/features/libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:biblio/features/libros/domain/entities/usuario.dart';
import 'package:provider/provider.dart';

class AdministracionDeBiblioteca {
  RepositorioBiblioteca adaptador = AdaptadorBibliotecaMemoria();

  registrarEntregaDeLibro(DateTime fecha, Libro libro, Usuario usuario) {
    final nuevoMovimiento = MovimientoDeBiblioteca(
        fecha: fecha, libro: libro, usuario: usuario, esDevolucion: false);
    adaptador.agregarMovimiento(nuevoMovimiento);
  }

  registrarDevolucionDeLibro(DateTime fecha, Libro libro, Usuario usuario) {}
}
