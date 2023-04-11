import 'package:flutter/material.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class ShowtimeForm extends StatelessWidget {
  const ShowtimeForm({
    super.key,
    required this.formKey,
    required this.showtime,
  });

  final GlobalKey<FormState> formKey;
  final Showtime showtime;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField2(
            value: showtime.movie,
            items: Provider.of<MovieProvider>(context)
                .movies
                .map((movie) => DropdownMenuItem<Movie>(
                      value: movie,
                      child: Text(movie.name),
                    ))
                .toList(),
            onChanged: (Movie? value) {
              showtime.movie = value!;
            },
            validator: (Movie? value) {
              if (value == null) {
                return 'Vui lòng chọn phim';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
