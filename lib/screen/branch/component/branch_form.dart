import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class BranchForm extends StatelessWidget {
  const BranchForm({
    super.key,
    required this.formKey,
    required this.branch,
  });

  final GlobalKey<FormState> formKey;
  final Branch branch;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: branch.name,
            decoration: const InputDecoration(labelText: 'Tên chi nhánh'),
            onSaved: (value) {
              branch.name = value!;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: branch.address,
            decoration: const InputDecoration(labelText: 'Địa chỉ'),
            onSaved: (value) {
              branch.address = value!;
            },
          ),
        ],
      ),
    );
  }
}
