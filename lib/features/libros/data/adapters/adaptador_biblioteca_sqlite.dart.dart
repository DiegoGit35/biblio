import 'dart:async';

import 'package:biblio/features/libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/libros/domain/entities/libro.dart';
import 'package:biblio/features/libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:biblio/features/libros/domain/entities/usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AdaptadorSQLite implements RepositorioBiblioteca {
  static Database? _database;
  static final AdaptadorSQLite db = AdaptadorSQLite();

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
      nuevoLibro.anioPublicacion,
      nuevoLibro.nombre,
      nuevoLibro.editorial,
      nuevoLibro.autores,
      nuevoLibro.isbn
    ]);
  }

  @override
  void agregarMovimiento(MovimientoDeBiblioteca nuevoMovimiento) async {
    final db = await database;

    final Map<String, dynamic> values = {
      'fecha': nuevoMovimiento.fecha.toIso8601String(),
      'dni': nuevoMovimiento.usuario.dni,
      'id_ejemplar': nuevoMovimiento.libro.idLibro,
      'es_devolucion': nuevoMovimiento.esDevolucion ? 1 : 0,
    };
    await db!.rawQuery(
        '''UPDATE libro SET disponibilidad = 'Prestado' WHERE id_ejemplar = (?) ''',
        [nuevoMovimiento.libro.idLibro]);
    await db.insert(
      'movimiento_de_biblioteca',
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> agregarUsuario(Usuario nuevoUsuario) async {
    return await _database!.rawInsert('''
      INSERT INTO socio (dni, telefono, nombre, apellido, email) VALUES (?,?,?,?,?)
''', [
      nuevoUsuario.dni,
      nuevoUsuario.telefono,
      nuevoUsuario.nombre,
      nuevoUsuario.apellido,
      nuevoUsuario.email
    ]);
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
  Future<List<Libro>> todosLosLibrosNoDevueltos() {
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> todosLosUsuarios() async {
    final db = await database;
    final List<Map<String, dynamic>> usuariosTodos = await db!.rawQuery('''
      SELECT * FROM socio
''');
    return usuariosTodos
        .map((usuario) => Usuario.fromSqfliteDatabase(usuario))
        .toList();
  }

  @override
  Future<List<MovimientoDeBiblioteca>> todosLosMovimientos() async {
    final db = await database;

    final List<Map<String, dynamic>> movimientosMap = await db!.rawQuery('''
    SELECT movimiento_de_biblioteca.*, 
           libro.titulo, libro.anio, libro.editorial, libro.estado_fisico, libro.disponibilidad, libro.isbn,
           socio.dni, socio.nombre, socio.apellido, socio.direccion, socio.telefono, socio.email
    FROM movimiento_de_biblioteca
    JOIN libro ON movimiento_de_biblioteca.id_ejemplar = libro.id_ejemplar
    JOIN socio ON movimiento_de_biblioteca.dni = socio.dni
  ''');

    List<MovimientoDeBiblioteca> movimientos = movimientosMap.map((map) {
      return MovimientoDeBiblioteca.fromSqfliteDatabase(map);
    }).toList();

    return movimientos;
  }

  @override
  Future<List<Libro>> librosDisponibles() async {
    final db = await database;
    final List<Map<String, dynamic>> librosTodos = await db!.rawQuery('''
      SELECT * FROM libro WHERE disponibilidad LIKE 'Disponible';
''');
    return librosTodos
        .map((libro) => Libro.fromSqfliteDatabase(libro))
        .toList();
  }

  @override
  void devolver(MovimientoDeBiblioteca movimiento) async {
    final db = await database;
    MovimientoDeBiblioteca devolucion = MovimientoDeBiblioteca(
      usuario: movimiento.usuario,
      libro: movimiento.libro,
      esDevolucion: true,
      fecha: movimiento.fecha,
    );
    await db!.rawQuery(
        '''UPDATE libro SET disponibilidad = 'Disponible' WHERE id_ejemplar = (?) ''',
        [devolucion.libro.idLibro]);

    final Map<String, dynamic> values = {
      'fecha': devolucion.fecha.toIso8601String(),
      'dni': devolucion.usuario.dni,
      'id_ejemplar': devolucion.libro.idLibro,
      'es_devolucion': devolucion.esDevolucion ? 1 : 0,
    };
    await db.insert(
      'movimiento_de_biblioteca',
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<MovimientoDeBiblioteca>>? movimientosPrestamos() async {
    final db = await database;
    final List<Map<String, dynamic>> prestamos = await db!.rawQuery('''
      SELECT movimiento_de_biblioteca.*, 
           libro.titulo, libro.anio, libro.editorial, libro.estado_fisico, libro.disponibilidad, libro.isbn,
           socio.dni, socio.nombre, socio.apellido, socio.direccion, socio.telefono, socio.email
    FROM movimiento_de_biblioteca
    JOIN libro ON movimiento_de_biblioteca.id_ejemplar = libro.id_ejemplar
    JOIN socio ON movimiento_de_biblioteca.dni = socio.dni
WHERE libro.disponibilidad = 'Prestado';
''');
    return prestamos
        .map((mov) => MovimientoDeBiblioteca.fromSqfliteDatabase(mov))
        .toList();
  }
}
