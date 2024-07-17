import 'package:biblio/features/administrar_libros/data/adapters/adaptador_biblioteca_sqlite.dart.dart';
import 'package:biblio/features/administrar_libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/administrar_libros/domain/entities/libro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            FutureBuilder<List<Libro>>(
                future: repo.todosLosLibros(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No books available'));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final book = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            title: Text(book.titulo),
                            subtitle: Text(book.autores),
                            isThreeLine: true,
                            trailing: Text(book.disponibilidad),
                          ),
                        );
                      },
                    );
                  }
                })
          ],
        ));
  }

//   Future<Widget> CardsDeLibros() async {
//     List<Libro> libros = await repo.todosLosLibros();
//     return await ListView.builder(
//       scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         print('Listview builder');
//         Libro? libro = libros[index];
//         return Card(
//           child: LibroACard(libro),
//         );
//       },
//     );
//   }

//   Widget LibroACard(Libro libro) {
//     // print(repo.todosLosLibros());
//     return Card(
//       child: Column(
//         children: [
//           ListTile(
//             leading: Icon(Icons.book),
//             title: Text(libro.titulo),
//           )
//         ],
//       ),
//     );
//   }
}
