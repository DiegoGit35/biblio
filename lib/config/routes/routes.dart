import 'package:biblio/features/administrar_libros/presentation/page/listar_libros.dart';
import 'package:flutter/material.dart';
import 'package:biblio/features/administrar_libros/presentation/page/alta_libro.dart';
import 'package:biblio/features/administrar_libros/presentation/page/home.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const HomePage(),
    'altaLibro': (BuildContext context) => const AltaLibro(),
    'listarLibros': (BuildContext context) => const ListarLibros()
  };
}
