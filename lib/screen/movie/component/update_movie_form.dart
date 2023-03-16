import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class UpdateMovieForm extends StatelessWidget {
  const UpdateMovieForm({
    super.key,
    required this.formKey,
    required this.movie,
  });

  final GlobalKey<FormState> formKey;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            initialValue: movie.name,
            decoration: const InputDecoration(
              labelText: 'Tên phim',
            ),
            onSaved: (value) {
              movie.name = value!;
            },
          ),
        ],
      ),
    );
  }
}
