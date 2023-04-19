import 'package:movie_ticket_booking_admin_flutter_nlu/screen/exception/base_exception.dart';

class BadRequestException extends BaseException {
  BadRequestException(String message) : super(message, 400);
}
