import 'package:movie_ticket_booking_admin_flutter_nlu/model/genre.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/provider/genre_provider.dart';

class GenreService {
  GenreService({required this.genreProvider});

  final GenreProvider genreProvider;

  Future<List<Genre>> getGenres() async {
    return await genreProvider.getGenres();
  }

  Future<Genre?> getGenreById(String id) async {
    return await genreProvider.getGenreById(id);
  }

  Future<void> addGenre(Genre genre) async {
    // await genreProvider.addGenre(genre);
  }

  Future<void> updateGenre(Genre genre) async {
    // await genreProvider.updateGenre(genre);
  }

  Future<void> deleteGenre(int id) async {
    // await genreProvider.deleteGenre(id);
  }
}
