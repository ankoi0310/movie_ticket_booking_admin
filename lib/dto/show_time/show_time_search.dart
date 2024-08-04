import 'package:intl/intl.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class ShowTimeSearch {
  Movie? movie;
  Branch? branch;
  DateTime? startTime;

  ShowTimeSearch({
    this.movie,
    this.branch,
    this.startTime,
  });

  ShowTimeSearch.empty()
      : movie = null,
        branch = null,
        startTime = null;

  // ShowTimeSearch.fromJson(Map<String, dynamic> json) {
  //   movie = json['movie'];
  //   branch = json['branch'];
  //   startTime = json['startTime'] != null
  //       ? DateFormat('dd-MM-yyyy HH:mm:ss').parse(json['startTime'])
  //       : null;
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if(movie != null) {
      data['movie'] = movie!.toJson();
    }
    if(branch != null) {
      data['branch'] = branch!.toJson();
    }
    if(startTime != null) {
      data['startTime'] = DateFormat('dd-MM-yyyy HH:mm:ss').format(startTime!);
    }

    return data;
  }
}