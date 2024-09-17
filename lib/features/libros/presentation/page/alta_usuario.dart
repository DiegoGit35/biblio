import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/repository/repositorio_biblioteca.dart';
import '../../domain/entities/usuario.dart';

class AltaUsuario extends StatefulWidget {
  const AltaUsuario({super.key});

  @override
  _CreateFormularioUsuario createState() => _CreateFormularioUsuario();
}

class _CreateFormularioUsuario extends State<AltaUsuario> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController apellidoController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController dniController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Alta Usuario",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _nombreUsuario(),
            _espacio(),
            _apellido(),
            _espacio(),
            _dni(),
            _espacio(),
            _email(),
            _espacio(),
            _telefono(),
            _espacio(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _guardarUsuario,
                child: const Text("Guardar Usuario"),
              ),
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

  Widget _nombreUsuario() {
    return TextField(
      controller: nombreController,
      autofocus: true,
      decoration: const InputDecoration(
        focusColor: Colors.blueGrey,
        hoverColor: Colors.blueGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        hintText: "Pedro",
        labelText: "Nombre del usuario",
      ),
    );
  }

  Widget _dni() {
    return TextField(
      controller: dniController,
      autofocus: true,
      decoration: const InputDecoration(
        focusColor: Colors.blueGrey,
        hoverColor: Colors.blueGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        hintText: "29339449",
        labelText: "DNI",
      ),
    );
  }

  Widget _email() {
    return TextField(
      controller: emailController,
      decoration: const InputDecoration(
        focusColor: Colors.blueGrey,
        hoverColor: Colors.blueGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        hintText: "pedro@gmail.com",
        labelText: "Cuenta de email",
      ),
    );
  }

  Widget _apellido() {
    return TextField(
      controller: apellidoController,
      decoration: const InputDecoration(
        focusColor: Colors.blueGrey,
        hintText: "Ramirez",
        labelText: "apellido",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _direccion() {
    return TextField(
      controller: direccionController,
      decoration: const InputDecoration(
        focusColor: Colors.blueGrey,
        hintText: "Av. libertador",
        labelText: "Dirección",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _telefono() {
    return TextField(
      controller: telefonoController,
      decoration: const InputDecoration(
        focusColor: Colors.blueGrey,
        hintText: "sin el 15",
        labelText: "telefono",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  void _guardarUsuario() {
    final adaptador =
        Provider.of<RepositorioBiblioteca>(context, listen: false);
    String nombre = nombreController.text;
    String email = emailController.text;
    String apellido = apellidoController.text;
    String dni = dniController.text;
    String telefono = telefonoController.text;
    String direccion = direccionController.text;

    if (nombre.isEmpty || email.isEmpty || apellido.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Todos los campos son obligatorios")),
      );
      return;
    }

    Usuario nuevoUsuario = Usuario(
      nombre: nombre,
      email: email,
      apellido: apellido,
      direccion: direccion,
      dni: dni,
      telefono: telefono,
    );

    adaptador.agregarUsuario(nuevoUsuario);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Usuario guardado con éxito")),
    );

    nombreController.clear();
    emailController.clear();
    apellidoController.clear();
  }
}
