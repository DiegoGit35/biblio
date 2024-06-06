import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AltaLibro extends StatefulWidget {
  @override
  _CreateFormularioLibro createState() => _CreateFormularioLibro();
}

class _CreateFormularioLibro extends State<AltaLibro> {
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

  Widget _editorialLibro() {
    List listNames = ["RBA", "Planeta", "Gredos"];

    return DropdownButtonFormField(items: listNames.map((name) {
      return DropdownMenuItem(child: Text(name), value: name);
    }), onChanged: (value) {
      print(value);
    });
  }
}
