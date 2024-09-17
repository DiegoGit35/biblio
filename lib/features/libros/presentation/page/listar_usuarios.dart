import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_memoria.dart';
import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_sqlite.dart.dart';
import 'package:biblio/features/libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/libros/domain/entities/usuario.dart';
import 'package:biblio/features/libros/presentation/page/listar_libros.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// RepositorioBiblioteca repo = AdaptadorSQLite();
// RepositorioBiblioteca repo = AdaptadorBibliotecaMemoria();

Future<List<Usuario>>? _data;

class ListarUsuarios extends StatefulWidget {
  const ListarUsuarios({super.key});

  @override
  State<StatefulWidget> createState() => ListarUsuariosState();
}

class ListarUsuariosState extends State<ListarUsuarios> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<RepositorioBiblioteca>(context, listen: false);
    _data = repo.todosLosUsuarios();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Usuario>>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('No hay usuarios disponibles'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final usuario = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          title: Text('${usuario.nombre} ${usuario.apellido}'),
                          subtitle: Text(usuario.email),
                          isThreeLine: true,
                          trailing: Text(usuario.telefono),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
