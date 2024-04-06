import 'package:biblio/model/libro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateLibroWidget extends StatefulWidget {
  final Libro? libro;
  final ValueChanged<String> onSubmit;

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
        child: TextFormField(
          autofocus: true,
          controller: controller,
          decoration: const InputDecoration(hintText: 'Titulo'),
          validator: (value) =>
              value != null && value.isEmpty ? 'Title is required' : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              widget.onSubmit(controller.text);
            }
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
