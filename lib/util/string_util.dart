import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/auth/app_role.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/invoice.dart';
import 'package:movie_ticket_booking_admin_flutter_nlu/model/seat.dart';

class StringUtil {
  static String convert(String str) {
    str = str.toLowerCase();
    str = str.replaceAll("à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ", "a");
    str = str.replaceAll("è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ", "e");
    str = str.replaceAll("ì|í|ị|ỉ|ĩ", "i");
    str = str.replaceAll("ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ", "o");
    str = str.replaceAll("ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ", "u");
    str = str.replaceAll("ỳ|ý|ỵ|ỷ|ỹ", "y");
    str = str.replaceAll("đ", "d");
    str = str.replaceAll(" ", "_");
    return str;
  }

  static String changeMovieFormat(MovieFormat movie) {
    switch (movie) {
      case MovieFormat.twoD:
        return "2D";
      case MovieFormat.threeD:
        return "3D";
      case MovieFormat.fourD:
        return "4DX";
      case MovieFormat.voiceOver:
        return "Lồng tiếng";
      default:
        return "2D";
    }
  }
  static String changeSeatType(SeatType type) {
    switch (type) {
      case SeatType.normal:
        return "Ghế đơn";
      case SeatType.couple:
        return "Ghế đôi";
      default:
        return "Ghế đơn";
    }
  }
  static String changeProductType(ProductType type) {
    switch (type) {
      case ProductType.drink:
        return "Thức uống";
      case ProductType.food:
        return "Đồ ăn";
      case ProductType.item:
        return "Vật phẩm";
      default:
        return "Thức uống";
    }
  }
  static String changePaymentStatus(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return "Đang chờ thanh toán";
      case PaymentStatus.success:
        return "Đã thanh toán";
      case PaymentStatus.failed:
        return "Huỷ thanh toán";
      default:
        return "Đang chờ thanh toán";
    }
  }
  static String changeRoleUser(String role) {
    switch (role) {
      case "ROLE_MANAGER":
        return "Quản lý";
      case "ROLE_ADMIN":
        return "Admin";
      case "ROLE_MEMBER":
        return "Khách hàng";
      default:
        return "Khách hàng";
    }
  }
}
