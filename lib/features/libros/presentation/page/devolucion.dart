import 'package:biblio/features/libros/domain/entities/libro.dart';
import 'package:biblio/features/libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:biblio/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repository/repositorio_biblioteca.dart';
import '../../domain/use_cases/administracion_de_biblioteca.dart';

class Devolucion extends StatefulWidget {
  const Devolucion({super.key});

  @override
  State<StatefulWidget> createState() => DevolucionState();
}

// RepositorioBiblioteca repo = AdaptadorSQLite();
// RepositorioBiblioteca repo = AdaptadorBibliotecaMemoria();

class DevolucionState extends State<Devolucion> {
  Future<List<MovimientoDeBiblioteca>>? movimientos;
  int? selectedMovimientoIndex;

  @override
  void initState() {
    super.initState();
  }

  // Función para registrar el préstamo
  void registrarDevolucion() async {
    if (selectedMovimientoIndex != null) {
      List<MovimientoDeBiblioteca> listaMovimientos = await movimientos!;
      final repo = Provider.of<RepositorioBiblioteca>(context, listen: false);
      // repo.todosLosMovimientos();
      DateTime fecha = DateTime.now();
      MovimientoDeBiblioteca devolver =
          listaMovimientos[selectedMovimientoIndex!];

      repo.devolver(devolver);
      // AdministracionDeBiblioteca().registrarDevolucionDeLibro(fecha, devolver.libro, devolver.usuario);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: const Text("Devolución registrado con éxito!"),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "Cerrar",
          onPressed: () {},
        ),
      ));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<RepositorioBiblioteca>(context, listen: false);
    movimientos = repo.movimientosPrestamos();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devolución de libro'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _mostrarMovimientos(movimientos)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: registrarDevolucion,
                child: const Text(
                  'Devolver libro',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mostrarMovimientos(data) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Seleccione el libro a devolver: ',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<MovimientoDeBiblioteca>>(
            future: movimientos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No hay movimientos'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final devolver = snapshot.data![index];
                    bool isSelected = index == selectedMovimientoIndex;

                    return Card(
                      child: ListTile(
                        title: Text('${devolver.libro.nombre}'),
                        subtitle: Text(
                            '${devolver.usuario.apellido} ${devolver.usuario.nombre}'),
                        isThreeLine: true,
                        trailing: Text('${devolver.fecha}'),
                        selected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedMovimientoIndex = index;
                          });
                        },
                        tileColor: isSelected
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.white,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
