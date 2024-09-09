import 'package:biblio/features/administrar_libros/domain/entities/libro_entity.dart';
import 'package:biblio/features/administrar_libros/domain/use_cases/get_libros_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  GetLibrosUseCase getLibrosUseCase;
  MockLibrosRepository mockLibrosRepository;
  mockLibrosRepository = MockLibrosRepository();
  getLibrosUseCase = GetLibrosUseCase(mockLibrosRepository);

  const List<LibroEntity> testLibroDetail = [
    LibroEntity(
      idLibro: 1,
      titulo: 'Cien años de soledad',
      editorial: 'Planeta',
      estadoFisico: "bueno",
      disponibilidad: 'Disponible',
      fechaRegistro: '2020-03-03',
      autores: 'Gabriel Garcia Marquez',
      anio: "1960",
      isbn: "123124184214",
    ),
    LibroEntity(
      idLibro: 2,
      titulo: "La Odisea",
      editorial: "Planeta",
      estadoFisico: "Bueno",
      disponibilidad: "Disponible",
      fechaRegistro: "2020-03-03",
      autores: "Homero",
      anio: "Desconocido",
      isbn: "1232412412412312",
    )
  ];

  test('debe devolver una lista de libros', () async {
    when(mockLibrosRepository.getLibros())
        .thenAnswer((_) async => const Right(testLibroDetail));

    final result = await getLibrosUseCase.execute();

    expect(result, const Right(testLibroDetail));
  });
}
