import 'package:biblio/features/administrar_libros/domain/entities/libro_entity.dart';
import 'package:biblio/features/administrar_libros/domain/use_cases/save_libro_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  SaveLibroUseCase saveLibroUseCase;
  MockLibrosRepository mockLibrosRepository;

  mockLibrosRepository = MockLibrosRepository();
  saveLibroUseCase = SaveLibroUseCase(mockLibrosRepository);

  const libroTest = LibroEntity(
    idLibro: 2,
    titulo: "La Odisea",
    editorial: "Planeta",
    estadoFisico: "Bueno",
    disponibilidad: "Disponible",
    fechaRegistro: "2020-03-03",
    autores: "Homero",
    anio: "Desconocido",
    isbn: "1232412412412312",
  );

  test('debe guardar un libro', () async {
    when(mockLibrosRepository.saveLibro(libroTest))
        .thenAnswer((_) async => const Right(libroTest));

    final result = await saveLibroUseCase.execute(libroTest);

    expect(result, const Right(libroTest));
  });
}
