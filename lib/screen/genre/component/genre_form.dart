import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class GenreForm extends StatelessWidget {
  const GenreForm({
    super.key,
    required this.formKey,
    required this.genre,
  });

  final GlobalKey<FormState> formKey;
  final Genre genre;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: genre.name,
            decoration: const InputDecoration(
              labelText: 'Tên thể loại',
            ),
            onSaved: (value) {
              genre.name = value!;
            },
          ),
        ],
      ),
    );
  }
}
