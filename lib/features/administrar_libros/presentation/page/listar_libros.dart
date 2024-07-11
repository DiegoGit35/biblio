import 'package:biblio/features/administrar_libros/data/adapters/adaptador_biblioteca_sqlite.dart.dart';
import 'package:biblio/features/administrar_libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/administrar_libros/domain/entities/libro.dart';
import 'package:flutter/material.dart';

class ListarLibros extends StatefulWidget {
  const ListarLibros({super.key});
  @override
  ListarLibrosState createState() => ListarLibrosState();
}

class ListarLibrosState extends State<ListarLibros> {
  RepositorioBiblioteca repo = AdaptadorSQLite();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todos los libros"),
        ),
        body: Column(
          children: [
            const Text(
              'nigger',
              style: TextStyle(color: Colors.black26),
            ),
            CardsDeLibros(),
          ],
        ));
  }

  Widget CardsDeLibros() {
    // Future<List<Libro>> listaLibros = repo.todosLosLibros();
    return FutureBuilder<List<Libro>>(
      future: repo.todosLosLibros(),
      builder: (context, snapshot) {
        print('future builder');
        return Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                print('Listview builder');
                Libro? libro = snapshot.data?[index];
                return Card(
                  child: LibroACard(libro!),
                );
              },
            )
          ],
        );
      },
    );
  }

  Widget LibroACard(Libro libro) {
    // print(repo.todosLosLibros());
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.book),
            title: Text(libro.titulo),
          )
        ],
      ),
    );
  }
}
