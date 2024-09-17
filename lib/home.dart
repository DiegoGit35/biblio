import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_memoria.dart';
import 'package:biblio/features/libros/data/repository/repositorio_biblioteca.dart';
import 'package:flutter/material.dart';

import 'package:biblio/features/libros/presentation/provider/menu_provider.dart';

import 'features/libros/presentation/utils/icono_string_util.dart';

class HomePage extends StatelessWidget {
  final RepositorioBiblioteca repo;
  HomePage({required this.repo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrar Libros'),
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
        return ListView(
          children: _listaItems(snapshot.data, context),
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
          // Navega a la nueva página pasando el repo como argumento
          Navigator.pushNamed(context, opt['ruta'], arguments: repo);
        },
      );

      opciones.add(widgetTemp);
      opciones.add(const Divider());
    });

    return opciones;
  }
}
