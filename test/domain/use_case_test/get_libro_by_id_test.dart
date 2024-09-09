import 'package:biblio/features/administrar_libros/domain/entities/libro_entity.dart';
import 'package:biblio/features/administrar_libros/domain/use_cases/get_libro_by_id_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  GetLibroByIdUseCase getLibroByIdUseCase;
  MockLibrosRepository mockLibrosRepository;

  mockLibrosRepository = MockLibrosRepository();
  getLibroByIdUseCase = GetLibroByIdUseCase(mockLibrosRepository);

  const libroTest = LibroEntity(
    idLibro: 1,
    titulo: 'Cien años de soledad',
    editorial: 'Planeta',
    estadoFisico: "bueno",
    disponibilidad: 'Disponible',
    fechaRegistro: '2020-03-03',
    autores: 'Gabriel Garcia Marquez',
    anio: "1960",
    isbn: "123124184214",
  );

  test('debe devolver un libro a partir de un id', () async {
    when(mockLibrosRepository.getLibroById(1))
        .thenAnswer((_) async => const Right(libroTest));

    final result = await getLibroByIdUseCase.execute(1);

    expect(result, const Right(libroTest));
  });
}
