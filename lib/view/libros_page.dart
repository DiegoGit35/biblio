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
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => CreateLibroWidget(
                onSubmit: (title) async {
                  await libroDB.create(
                      idLibro: idLibro,
                      idEjemplar: idEjemplar,
                      anio: anio,
                      titulo: titulo,
                      editorial: editorial,
                      estadoFisico: estadoFisico,
                      disponibilidad: disponibilidad,
                      autores: autores,
                      isbn: isbn,
                      fechaRegistro: fechaRegistro);
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
