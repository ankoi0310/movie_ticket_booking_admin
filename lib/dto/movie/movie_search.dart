import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class MovieSearch {
  String? name;
  int? duration;
  MovieState? movieState;
  MovieFormat? movieFormat;

  MovieSearch({
    this.name,
    this.duration,
    this.movieState,
    this.movieFormat,
  });

  MovieSearch.empty()
      : name = '',
        duration = 0,
        movieState = MovieState.nowShowing,
        movieFormat = MovieFormat.twoD;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (name != null) {
      data['name'] = name;
    }
    if (duration != null) {
      data['duration'] = duration;
    }
    if (movieState != null) {
      data['state'] = movieState!.value;
    }
    if (movieFormat != null) {
      data['movieFormat'] = movieFormat!.value;
    }

    return data;
  }
}
