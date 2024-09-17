import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_sqlite.dart.dart';
import 'package:biblio/features/libros/data/repository/repositorio_biblioteca.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/adapters/adaptador_biblioteca_memoria.dart';
import '../../domain/entities/libro.dart';

class AltaLibro extends StatefulWidget {
  const AltaLibro({super.key});

  @override
  _CreateFormularioLibro createState() => _CreateFormularioLibro();
}

class _CreateFormularioLibro extends State<AltaLibro> {
  List<String> editoriales = ["RBA", "Planeta", "Gredos"];
  String? editorialSeleccionada = 'RBA';

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController anioController = TextEditingController();
  final TextEditingController isbnController = TextEditingController();

  // AdaptadorBibliotecaMemoria adaptador = AdaptadorBibliotecaMemoria();

  @override
  Widget build(BuildContext context) {
    final adaptador = Provider.of<RepositorioBiblioteca>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alta Libro",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _nombreLibro(),
            _espacio(),
            _anio(),
            _espacio(),
            _isbn(),
            _espacio(),
            _editorialLibro(),
            _espacio(),
            ElevatedButton(
              onPressed: _guardarLibro,
              child: const Text("Guardar Libro"),
            )
          ],
        ),
      ),
    );
  }

  Widget _espacio() {
    return const SizedBox(
      height: 20.0,
    );
  }

  Widget _nombreLibro() {
    return TextField(
      controller: nombreController,
      autofocus: true,
      decoration: const InputDecoration(
        focusColor: Colors.blueGrey,
        hoverColor: Colors.blueGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        hintText: "Don Quixote",
        labelText: "Nombre del libro",
      ),
    );
  }

  Widget _anio() {
    return TextField(
      controller: anioController,
      decoration: const InputDecoration(
        focusColor: Colors.blueGrey,
        hoverColor: Colors.blueGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        hintText: "1984",
        labelText: "Año de publicación",
      ),
    );
  }

  Widget _isbn() {
    return TextField(
      controller: isbnController,
      decoration: const InputDecoration(
        focusColor: Colors.blueGrey,
        hintText: "5719345892357218",
        labelText: "ISBN",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getEditoriales() {
    return editoriales.map((String editorial) {
      return DropdownMenuItem<String>(
        value: editorial,
        child: Text(editorial),
      );
    }).toList();
  }

  Widget _editorialLibro() {
    return DropdownButtonFormField(
      borderRadius: BorderRadius.circular(20),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      value: editorialSeleccionada,
      items: getEditoriales(),
      onChanged: (value) {
        setState(() {
          editorialSeleccionada = value;
        });
      },
    );
  }

  // Método para guardar el libro
  void _guardarLibro() {
    final adaptador =
        Provider.of<RepositorioBiblioteca>(context, listen: false);

    String nombre = nombreController.text;
    String anio = anioController.text;
    String isbn = isbnController.text;
    String editorial = editorialSeleccionada ?? 'Sin editorial';

    if (nombre.isEmpty || anio.isEmpty || isbn.isEmpty) {
      // Validación básica para asegurarse de que los campos no estén vacíos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Todos los campos son obligatorios")),
      );
      return;
    }

    // Crear un nuevo objeto Libro (el constructor de Libro debe estar definido)
    Libro nuevoLibro = Libro(
      nombre: nombre,
      anioPublicacion: anio,
      isbn: isbn,
      editorial: editorial,
    );

    // Guardar el libro usando el adaptador
    adaptador.agregarLibro(nuevoLibro);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Libro guardado con éxito")),
    );

    // Opcionalmente, puedes limpiar los campos del formulario después de guardar
    nombreController.clear();
    anioController.clear();
    isbnController.clear();
  }
}
