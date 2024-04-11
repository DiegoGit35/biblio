import 'package:biblio/model/libro.dart';
import 'package:flutter/material.dart';

class CreateLibroWidget extends StatefulWidget {
  final Libro? libro;
  final ValueChanged<Libro?> onSubmit;

  const CreateLibroWidget({
    Key? key,
    this.libro,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<CreateLibroWidget> createState() => _CreateLibroWidgetState();
}

class _CreateLibroWidgetState extends State<CreateLibroWidget> {
  final controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    controller.text = widget.libro?.titulo ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.libro != null;
    return AlertDialog(
      title: Text(isEditing ? 'Edit libro' : 'Add libro'),
      content: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: 'ID del Ejempar'),
                validator: (value) =>
                    value != null && value.isEmpty ? 'ID is required' : null,
                onSaved: (idEjemplar) {
                  widget.libro?.idEjemplar = idEjemplar!;
                },
              ),
              TextFormField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: 'año'),
                validator: (value) =>
                    value != null && value.isEmpty ? 'Año is required' : null,
                onSaved: (anio) {
                  widget.libro?.anio = anio as int;
                },
              ),
              TextFormField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: 'Titulo'),
                validator: (value) =>
                    value != null && value.isEmpty ? 'Title is required' : null,
                onSaved: (titulo) {
                  widget.libro?.titulo = titulo!;
                },
              ),
              TextFormField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: 'Editorial'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Editorial is required'
                    : null,
                onSaved: (editorial) {
                  widget.libro?.editorial = editorial!;
                },
              ),
              TextFormField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: 'Estado físico'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Estado fisico is required'
                    : null,
                onSaved: (estadoFisico) {
                  widget.libro?.estadoFisico = estadoFisico!;
                },
              ),
              TextFormField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: 'Disponibilidad'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Disponibilidad is required'
                    : null,
                onSaved: (disponibilidad) {
                  widget.libro?.disponibilidad = disponibilidad!;
                },
              ),
              TextFormField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: 'Autores'),
                validator: (value) => value != null && value.isEmpty
                    ? 'Autores is required'
                    : null,
                onSaved: (autores) {
                  widget.libro?.autores = autores!;
                },
              ),
              TextFormField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: 'ISBN'),
                validator: (value) =>
                    value != null && value.isEmpty ? 'ISBN is required' : null,
                onSaved: (isbn) {
                  widget.libro?.isbn = isbn! as int;
                },
              ),
            ],
          )),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              widget.onSubmit(widget.libro);
            }
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
