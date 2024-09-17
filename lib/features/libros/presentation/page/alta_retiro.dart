import 'package:biblio/features/libros/data/adapters/adaptador_biblioteca_sqlite.dart.dart';
import 'package:biblio/features/libros/data/repository/repositorio_biblioteca.dart';
import 'package:biblio/features/libros/domain/entities/movimientosDeBiblioteca.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../../../home.dart';
import '../../../../main.dart';
import '../../data/adapters/adaptador_biblioteca_memoria.dart';
import '../../domain/entities/libro.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/use_cases/administracion_de_biblioteca.dart';

class AltaRetiro extends StatefulWidget {
  const AltaRetiro({super.key});

  @override
  State<StatefulWidget> createState() => AltaRetiroState();
}

// RepositorioBiblioteca repo = AdaptadorSQLite();
// RepositorioBiblioteca repo = AdaptadorBibliotecaMemoria();

class AltaRetiroState extends State<AltaRetiro> {
  Future<List<Usuario>>? usuarios;
  Future<List<Libro>>? libros;
  int? selectedUsuario;
  int? selectedLibro;

  @override
  void initState() {
    super.initState();
  }

  // Función para registrar el préstamo
  void registrarPrestamo() async {
    if (selectedUsuario != null && selectedLibro != null) {
      List<Usuario> listaUsuarios = await usuarios!;
      List<Libro> listaLibros = await libros!;

      Usuario usuario = listaUsuarios[selectedUsuario!];
      Libro libro = listaLibros[selectedLibro!];

      DateTime fecha = DateTime.now();
      AdministracionDeBiblioteca()
          .registrarEntregaDeLibro(fecha, libro, usuario);
      final repo = Provider.of<RepositorioBiblioteca>(context, listen: false);
      repo.agregarMovimiento(MovimientoDeBiblioteca(
          usuario: usuario, libro: libro, esDevolucion: false, fecha: fecha));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: const Text("Préstamo registrado con éxito!"),
        action: SnackBarAction(
          textColor: Colors.white,
          label: "Cerrar",
          onPressed: () {},
        ),
      ));

      // Navegar o realizar otra acción después de registrar
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = Provider.of<RepositorioBiblioteca>(context, listen: false);

    usuarios = repo.todosLosUsuarios();
    libros = repo.librosDisponibles();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retirar libro'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _mostrarUsuarios(usuarios)),
                Expanded(child: _mostrarLibros(libros)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: registrarPrestamo,
                child: const Text(
                  'Registrar Préstamo',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mostrarUsuarios(data) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Seleccione el usuario: ',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Usuario>>(
            future: usuarios,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No hay usuarios disponibles'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final usuario = snapshot.data![index];
                    bool isSelected = index == selectedUsuario;

                    return Card(
                      child: ListTile(
                        title: Text('${usuario.nombre} ${usuario.apellido}'),
                        subtitle: Text(usuario.email),
                        isThreeLine: true,
                        trailing: Text(usuario.telefono),
                        selected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedUsuario = index;
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

  Widget _mostrarLibros(Future<List<Libro>>? libros) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Seleccione el libro: ',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<Libro>>(
            future: libros,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No hay libros disponibles'));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final book = snapshot.data![index];
                    bool isSelected = index == selectedLibro;

                    return Card(
                      child: ListTile(
                        title: Text(book.nombre!),
                        subtitle: Text(book.isbn!),
                        isThreeLine: true,
                        trailing: Text(book.anioPublicacion!),
                        selected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedLibro = index;
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
