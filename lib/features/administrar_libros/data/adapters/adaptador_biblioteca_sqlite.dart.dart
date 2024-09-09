import 'dart:async';

import 'package:biblio/features/administrar_libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/administrar_libros/domain/entities/libro.dart';
import 'package:biblio/features/administrar_libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:biblio/features/administrar_libros/domain/entities/usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AdaptadorSQLite implements RepositorioBiblioteca {
  static Database? _database;
  static final AdaptadorSQLite db = AdaptadorSQLite();

  // AdaptadorSQLite._();
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    final databaseDirecotry = await getDatabasesPath();
    final path = join(databaseDirecotry, 'biblioteca.db');

    if (kDebugMode) {
      print('path $path');
    }

    final data = openDatabase(
      path,
      version: 2,
    );
    return await data;
  }

  @override
  Future<int> agregarLibro(Libro nuevoLibro) async {
    return await _database!.rawInsert('''
      INSERT INTO libro (anio, titulo, editorial, autores, isbn) VALUES (?,?,?,?,?)
''', [
      nuevoLibro.anio,
      nuevoLibro.titulo,
      nuevoLibro.editorial,
      nuevoLibro.autores,
      nuevoLibro.isbn
    ]);
  }

  @override
  void agregarMovimiento(MovimientoDeBiblioteca nuevoMovimiento) {}

  @override
  void agregarUsuario(Usuario nuevoUsuario) {
    // TODO: implement agregarUsuario
  }

  @override
  Future<List<Libro>> todosLosLibros() async {
    final db = await database;
    final List<Map<String, dynamic>> librosTodos = await db!.rawQuery('''
      SELECT * FROM libro
''');
    return librosTodos
        .map((libro) => Libro.fromSqfliteDatabase(libro))
        .toList();
  }

  @override
  List<Libro> todosLosLibrosNoDevueltos() {
    // TODO: implement todosLosLibrosNoDevueltos
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> todosLosUsuarios() {
    // TODO: implement todosLosUsuarios
    throw UnimplementedError();
  }
}
