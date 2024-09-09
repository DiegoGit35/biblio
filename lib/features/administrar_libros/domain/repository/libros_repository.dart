import 'package:biblio/core/error/failure.dart';
import 'package:biblio/features/administrar_libros/domain/entities/libro_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LibrosRepository {
  Future<Either<Failure, List<LibroEntity>>> getLibros();
  Future<Either<Failure, LibroEntity>> getLibroById(int idLibro);
  Future<Either<Failure, LibroEntity>> saveLibro(LibroEntity libro);
  Future<Either<Failure, LibroUpdate>> updateLibro(LibroUpdate libro);
  Future<void> deleteLibro(int idLibro);
}
