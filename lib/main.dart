import 'dart:io';

import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_memoria.dart';
import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_sqlite.dart.dart';
import 'package:biblio/features/libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/libros/presentation/provider/menu_provider.dart';
import 'package:biblio/features/libros/presentation/utils/icono_string_util.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:biblio/config/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:componentes/src/pages/alert_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa SQLite si es necesario (ej. para Windows/Linux)
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    MultiProvider(
      providers: [
        Provider<RepositorioBiblioteca>(
          create: (_) => AdaptadorSQLite(), // Inicializa con AdaptadorSQLite
        ),
      ],
      child: const MyApp(),
    ),
  );
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
        print('Ruta llamada: ${settings.name}');
        return null;
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RepositorioBiblioteca _repo;

  @override
  void initState() {
    super.initState();
    _repo =
        context.read<RepositorioBiblioteca>(); // Obtiene el repositorio inicial
  }

  // Método para alternar entre AdaptadorSQLite y AdaptadorBibliotecaMemoria
  void _cambiarRepositorio() {
    setState(() {
      if (_repo is AdaptadorSQLite) {
        _repo = AdaptadorBibliotecaMemoria();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usando AdaptadorBibliotecaMemoria')),
        );
      } else {
        _repo = AdaptadorSQLite();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Usando AdaptadorSQLite')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Libros'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: _cambiarRepositorio, // Cambiar repositorio al presionar
          child: const Icon(Icons.swap_horiz),
          tooltip: 'Cambiar Repositorio',
        ),
      ),
      body: Container(
        child: _lista(context), // Pasa context aquí
      ),
    );
  }

  Widget _lista(BuildContext context) {
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: const [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: _listaItems(snapshot.data, context),
          ),
        );
      },
    );
  }

  List<Widget> _listaItems(List<dynamic>? data, BuildContext context) {
    final List<Widget> opciones = [];

    data?.forEach((opt) {
      final widgetTemp = ListTile(
        hoverColor: Colors.blue[50],
        title: Text(opt['texto']),
        leading: getIcon(opt['icon']),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.pushNamed(context, opt['ruta'], arguments: _repo);
        },
      );

      opciones.add(widgetTemp);
      opciones.add(const Divider());
    });

    return opciones;
  }
}
