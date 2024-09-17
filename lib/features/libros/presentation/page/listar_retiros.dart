import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_memoria.dart';
import 'package:biblio/features/libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/adapters/adaptador_biblioteca_sqlite.dart.dart';
import '../../data/repository/repositorio_biblioteca.dart';

class ListarRetiros extends StatefulWidget {
  const ListarRetiros({super.key});

  @override
  State<StatefulWidget> createState() => ListarRetirosState();
}

class ListarRetirosState extends State<ListarRetiros> {
  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<RepositorioBiblioteca>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros no devueltos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<MovimientoDeBiblioteca>>(
              future: repo.movimientosPrestamos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay libros disponibles'));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final movimiento = snapshot.data![index];
                      return Card(
                        child: ListTile(
                          title: Text('${movimiento.libro.nombre}'),
                          subtitle: Text(
                              '${movimiento.usuario.apellido} ${movimiento.usuario.nombre}'),
                          isThreeLine: true,
                          trailing: Text(movimiento.fecha.toString()),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
