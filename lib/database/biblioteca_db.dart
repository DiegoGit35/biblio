import 'package:sqflite/sqflite.dart';
import 'package:biblio/database/database_service.dart';
import 'package:biblio/model/libro.dart';

class BibliotecaDB {
  final tableName = 'Libro';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS libro(
  id_libro integer PRIMARY KEY,
  id_ejemplar integer NOT NULL,
  anio  integer NOT NULL,
  titulo  text NOT NULL,
  editorial text NOT NULL,
  estado_fisico text NOT NULL DEFAULT "Bueno",
  disponibilidad text NOT NULL DEFAULT "Disponible",
  fecha_registro current_timestamp NOT NULL DEFAULT CURRENT_DATE,
  autores text NOT NULL,
  isbn  integer NOT NULL,
  fecha_baja text
);""");
  }

  Future<int> create(
      {required String idLibro,
      required String idEjemplar,
      required int anio,
      required String titulo,
      required String editorial,
      required String estadoFisico,
      required String disponibilidad,
      required String autores,
      required int isbn,
      required String fechaRegistro}) async {
    final database = await DatabaseService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName(id_libro, id_ejemplar, anio, titulo, editorial, estado_fisico, disponibilidad, fecha_registro, autores, isbn, fecha_baja) VALUES (?, ?, ?, ?, ?, ?, ?)''',
      [
        idLibro,
        idEjemplar,
        anio,
        titulo,
        editorial,
        estadoFisico,
        disponibilidad,
        fechaRegistro,
        autores,
        isbn,
      ],
    );
  }

  Future<List<Libro>> fetchAll() async {
    final database = await DatabaseService().database;
    final libros = await database.rawQuery('''SELECT * FROM $tableName''');
    return libros.map((libro) => Libro.fromSqfliteDatabase(libro)).toList();
  }

  Future<Libro> fetchById(int id_libro) async {
    final database = await DatabaseService().database;
    final libro = await database
        .rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id_libro]);
    return Libro.fromSqfliteDatabase(libro.first);
  }

  Future<int> update({required int idLibro, String? titulo}) async {
    final database = await DatabaseService().database;
    return await database.update(
      tableName,
      {
        if (titulo != null) 'title': titulo,
        //'updated_at': DateTime.now().toString(),
      },
      where: 'id_libro = ?',
      conflictAlgorithm: ConflictAlgorithm.rollback,
      whereArgs: [idLibro],
    );
  }

  Future<void> delete(int id) async {
    final database = await DatabaseService().database;
    await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }
}
