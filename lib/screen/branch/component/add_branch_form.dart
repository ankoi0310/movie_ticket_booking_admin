import 'package:flutter/material.dart';

class AddBranchForm extends StatelessWidget {
  const AddBranchForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.addressController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Tên chi nhánh'),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Địa chỉ'),
          ),
        ],
      ),
    );
  }
}
