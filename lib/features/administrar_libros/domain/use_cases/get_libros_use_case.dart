import 'package:biblio/core/error/failure.dart';
import 'package:biblio/features/administrar_libros/domain/entities/libro_entity.dart';
import 'package:biblio/features/administrar_libros/domain/repository/libros_repository.dart';
import 'package:dartz/dartz.dart';

class GetLibrosUseCase {
  final LibrosRepository librosRepository;
  GetLibrosUseCase(this.librosRepository);

  Future<Either<Failure, List<LibroEntity>>> execute() {
    return librosRepository.getLibros();
  }
}
