import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    final databaseDirecotry = await getApplicationDocumentsDirectory();
    final path = join(databaseDirecotry.path, 'biblioteca.db');

    if (kDebugMode) {
      print('path $path');
    }

    final data = openDatabase(
      path,
      version: 1,
    );
    return await data;
  }
}
