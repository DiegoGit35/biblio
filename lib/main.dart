import 'dart:io';

import 'package:biblio/features/administrar_libros/data/adapters/adaptador_biblioteca_sqlite.dart.dart';
import 'package:biblio/features/administrar_libros/data/repository/repositorio_biblioteca.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:biblio/config/routes/routes.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:componentes/src/pages/alert_page.dart';

RepositorioBiblioteca repsoitorio = AdaptadorSQLite();

void main() async {
  if (Platform.isWindows || Platform.isLinux) sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  WidgetsFlutterBinding.ensureInitialized();
  AdaptadorSQLite.db.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Componentes APP',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getApplicationRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        print('Ruta llamda: ${settings.name}');
        return null;

        // return MaterialPageRoute(
        // builder: (BuildContext context) => AlertPage());
      },
    );
  }
}
