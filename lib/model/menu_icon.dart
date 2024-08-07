import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class MenuItem {
  final String icon;
  final String title;
  final AuthRouteData route;

  MenuItem({
    required this.icon,
    required this.title,
    required this.route,
  });
}

final List<MenuItem> sideBarMenuItems = [
  MenuItem(
    icon: '/icons/dashboard.svg',
    title: 'Trang chủ',
    route: AuthRouteData.dashboard,
  ),
  MenuItem(
    icon: '/icons/user.svg',
    title: 'Người dùng',
    route: AuthRouteData.user,
  ),
  MenuItem(
    icon: '/icons/movie.svg',
    title: 'Phim',
    route: AuthRouteData.movie,
  ),
  MenuItem(
    icon: '/icons/genre.svg',
    title: 'Thể loại',
    route: AuthRouteData.genre,
  ),
  MenuItem(
    icon: '/icons/branch.svg',
    title: 'Chi nhánh',
    route: AuthRouteData.branch,
  ),
  MenuItem(
    icon: '/icons/room.svg',
    title: 'Phòng chiếu',
    route: AuthRouteData.room,
  ),
  MenuItem(
    icon: '/icons/product.svg',
    title: 'Sản phẩm',
    route: AuthRouteData.product,
  ),
  MenuItem(
    icon: '/icons/product.svg',
    title: 'Combo sản phẩm',
    route: AuthRouteData.combo,
  ),
  MenuItem(
    icon: '/icons/showtime.svg',
    title: 'Lịch chiếu',
    route: AuthRouteData.showtime,
  ),
  MenuItem(
    icon: '/icons/ticket.svg',
    title: 'Hóa đơn',
    route: AuthRouteData.invoice,
  ),
  MenuItem(
    icon: '/icons/trophy.svg',
    title: 'Khuyến mãi',
    route: AuthRouteData.promotion,
  ),
  MenuItem(
    icon: 'assets/icons/advertisement.svg',
    title: 'Quảng cáo',
    route: AuthRouteData.advertisement,
  ),
  MenuItem(
    icon: '/icons/pie-chart.svg',
    title: 'Thống kê',
    route: AuthRouteData.statistic,
  ),
];
