import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_memoria.dart';
import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_sqlite.dart.dart';
import 'package:biblio/features/libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/libros/domain/entities/libro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ListarLibros extends StatefulWidget {
  const ListarLibros({super.key});
  @override
  ListarLibrosState createState() => ListarLibrosState();
}

class ListarLibrosState extends State<ListarLibros> {
  // RepositorioBiblioteca repo = AdaptadorSQLite();
  // RepositorioBiblioteca repo = AdaptadorBibliotecaMemoria();

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<RepositorioBiblioteca>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todos los libros"),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Libro>>(
                future: repo.todosLosLibros(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay libros disponibles'));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final book = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            title: Text(book.nombre!),
                            subtitle: Text(book.isbn!),
                            isThreeLine: true,
                            trailing: Text(book.anioPublicacion!),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
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
