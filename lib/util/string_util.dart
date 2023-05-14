import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

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
}
