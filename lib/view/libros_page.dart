import 'package:biblio/database/biblioteca_db.dart';
import 'package:biblio/model/libro.dart';
import 'package:biblio/widget/create_libro_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LibrosPage extends StatefulWidget {
  const LibrosPage({super.key});

  @override
  State<LibrosPage> createState() => _LibrosPageState();
}

class _LibrosPageState extends State<LibrosPage> {
  Future<List<Libro>>? futureLibros;
  final libroDB = BibliotecaDB();

  @override
  void initState() {
    super.initState();

    fetchLibros();
  }

  void fetchLibros() {
    setState(() {
      futureLibros = libroDB.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Libros '),
        ),
        body: FutureBuilder<List<Libro>>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final libros = snapshot.data!;

              return libros.isEmpty
                  ? const Center(
                      child: Text(
                      "No hay libros",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ))
                  : ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: libros.length,
                      itemBuilder: (context, index) {
                        final libro = libros[index];

                        return ListTile(
                          title: Text(
                            libro.titulo,
                            style: const TextStyle(fontSize: 8),
                          ),
                          subtitle: Text(libro.editorial),
                          trailing: IconButton(
                            onPressed: () async {
                              // await libroDB.delete(libro.idLibro);
                              fetchLibros();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => CreateLibroWidget(
                                libro: libro,
                                onSubmit: (libro) async {
                                  await libroDB.update(
                                      idLibro: libro!.idLibro,
                                      titulo: libro.titulo);
                                  fetchLibros();
                                  if (!mounted) return;
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                        );
                      },
                    );
            }
          },
          future: futureLibros,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => CreateLibroWidget(
                onSubmit: (libro) async {
                  await libroDB.create(
                      idLibro: libro!.idLibro,
                      idEjemplar: libro.idEjemplar,
                      anio: libro.anio,
                      titulo: libro.titulo,
                      editorial: libro.editorial,
                      estadoFisico: libro.estadoFisico,
                      disponibilidad: libro.disponibilidad,
                      autores: libro.autores,
                      isbn: libro.isbn,
                      fechaRegistro: libro.fechaRegistro);
                  if (!mounted) return;
                  fetchLibros();
                  Navigator.of(context).pop();
                },
              ),
            );
          },
        ),
      );
}
