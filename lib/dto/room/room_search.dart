import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class RoomSearch {
  Branch? branch;

  RoomSearch({
    this.branch,
  });

  RoomSearch.empty()
      : branch = null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    return data;
  }
}
