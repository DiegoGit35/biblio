import 'package:biblio/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../entities/libro.dart';

abstract class LibrosRepository {
  Future<Either<Failure, List<Libro>>> getLibros();
  Future<Either<Failure, Libro>> getLibroById(int idLibro);
  Future<Either<Failure, Libro>> saveLibro(Libro libro);
  Future<Either<Failure, Libro>> updateLibro(Librolibro);
  Future<void> deleteLibro(int idLibro);
}
