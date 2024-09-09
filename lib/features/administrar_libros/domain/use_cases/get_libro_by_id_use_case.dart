import 'package:biblio/core/error/failure.dart';
import 'package:biblio/features/administrar_libros/domain/entities/libro_entity.dart';
import 'package:biblio/features/administrar_libros/domain/repository/libros_repository.dart';
import 'package:dartz/dartz.dart';

class GetLibroByIdUseCase {
  final LibrosRepository librosRepository;
  GetLibroByIdUseCase(this.librosRepository);

  Future<Either<Failure, LibroEntity>> execute(int idLibro) {
    return librosRepository.getLibroById(idLibro);
  }
}
