import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'libro.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // si hay algun bug seguro es aca xd
  final database = await openDatabase(
      '/home/diego/Documents/Flutter/biblio/lib/biblioteca.db');

  Future<void> insterLibro(Libro libro) async {
    final db = await database;
    await db.insert(
      'Libro',
      libro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
