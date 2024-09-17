import 'dart:io';

import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_memoria.dart';
import 'package:biblio/features/libros/presentation/page/devolucion.dart';
import 'package:biblio/features/libros/presentation/page/listar_libros.dart';
import 'package:biblio/features/libros/presentation/page/listar_retiros.dart';
import 'package:biblio/features/libros/presentation/page/listar_usuarios.dart';
import 'package:flutter/material.dart';
import 'package:biblio/features/libros/presentation/page/alta_libro.dart';
import 'package:path/path.dart';

import '../../features/libros/presentation/page/alta_retiro.dart';
import '../../features/libros/presentation/page/alta_usuario.dart';
import '../../home.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(repo: AdaptadorBibliotecaMemoria()),
    'altaLibro': (BuildContext context) => const AltaLibro(),
    'listarLibros': (BuildContext context) => const ListarLibros(),
    'listarUsuarios': (context) => const ListarUsuarios(),
    'altaUsuario': (context) => const AltaUsuario(),
    'altaRetiro': (context) => const AltaRetiro(),
    'listarNoDevueltos': (context) => const ListarRetiros(),
    'altaDevolucion': (context) => const Devolucion(),
    'salir': (context) {
      exit(0);
    },
  };
}
