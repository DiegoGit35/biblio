import 'dart:convert';

import 'package:biblio/features/administrar_libros/data/models/libro_model.dart';
import 'package:biblio/features/administrar_libros/domain/entities/libro_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  const libroModelTest = LibroModel(
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

  test('debe ser una subclass de LibroEntity', () async {
    expect(libroModelTest, isA<LibroEntity>());
  });

  test("deberia devolver un objeto libroModel a partir de un json", () async {
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy_data/libro_map_dummy.json'));
    final result = LibroModel.fromSqfliteDatabase(jsonMap);

    expect(result, equals(libroModelTest));
  });
}
