import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AltaLibro extends StatefulWidget {
  @override
  _CreateFormularioLibro createState() => _CreateFormularioLibro();
}

class _CreateFormularioLibro extends State<AltaLibro> {
  List<String> editoriales = ["RBA", "Planeta", "Gredos"];

  String? editorialSeleccionada = 'RBA';

  @override
  Widget build(BuildContext context) {
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
            _ocupaEspacio(),
            _anio(),
            _ocupaEspacio(),
            _isbn(),
            _ocupaEspacio(),
            _editorialLibro(),
          ],
        ),
      ),
    );
  }

  Widget _ocupaEspacio() {
    return const SizedBox(
      height: 20.0,
    );
  }

  Widget _nombreLibro() {
    return const TextField(
      autofocus: true,
      decoration: InputDecoration(
          focusColor: Colors.blueGrey,
          hoverColor: Colors.blueGrey,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          hintText: "Don Quixote",
          labelText: "Nombre del libro"),
    );
  }

  Widget _anio() {
    return const TextField(
      decoration: InputDecoration(
          focusColor: Colors.blueGrey,
          hoverColor: Colors.blueGrey,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          hintText: "1984",
          labelText: "Año de publicación"),
    );
  }

  Widget _isbn() {
    return const TextField(
      decoration: InputDecoration(
        focusColor: Colors.blueGrey,
        hintText: "5719345892357218",
        labelText: "ISBN",
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  List<DropdownMenuItem<String>> getEditoriales() {
    List<DropdownMenuItem<String>> listaEditoriales = [];

    for (var editorial in editoriales) {
      // print(editorial);
      listaEditoriales.add(DropdownMenuItem(
        value: editorial,
        child: Text(editorial),
      ));
    }
    return listaEditoriales;
  }

  Widget _editorialLibro() {
    return DropdownButtonFormField(
        borderRadius: BorderRadius.circular(20),
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        value: editorialSeleccionada,
        items: getEditoriales(),
        onChanged: (value) {
          setState(() {
            editorialSeleccionada = value;
          });
        });
  }
}
