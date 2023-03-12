import 'package:flutter/material.dart';

class AddGenreForm extends StatelessWidget {
  const AddGenreForm({
    super.key,
    required this.formKey,
    required this.nameController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Tên thể loại',
            ),
          ),
        ],
      ),
    );
  }
}
