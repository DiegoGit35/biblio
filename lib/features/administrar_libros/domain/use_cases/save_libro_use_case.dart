import 'package:biblio/core/error/failure.dart';
import 'package:biblio/features/administrar_libros/domain/entities/libro_entity.dart';
import 'package:biblio/features/administrar_libros/domain/repository/libros_repository.dart';
import 'package:dartz/dartz.dart';

class SaveLibroUseCase {
  final LibrosRepository librosRepository;
  SaveLibroUseCase(this.librosRepository);

  Future<Either<Failure, LibroEntity>> execute(LibroEntity libro) {
    return librosRepository.saveLibro(libro);
  }
}
