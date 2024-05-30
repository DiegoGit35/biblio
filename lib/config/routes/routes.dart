import 'package:flutter/material.dart';
import 'package:biblio/features/administrar_libros/presentation/page/alta_libro.dart';
import 'package:biblio/features/administrar_libros/presentation/page/home.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'altaLibro': (BuildContext context) => AltaLibro(),
  };
}
