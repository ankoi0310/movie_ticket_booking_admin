import 'package:movie_ticket_booking_admin_flutter_nlu/core.dart';

class MenuItem {
  final String icon;
  final String title;
  final RouteData route;

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
    route: RouteData.dashboard,
  ),
  MenuItem(
    icon: '/icons/user.svg',
    title: 'Người dùng',
    route: RouteData.user,
  ),
  MenuItem(
    icon: '/icons/movie.svg',
    title: 'Phim',
    route: RouteData.movie,
  ),
  MenuItem(
    icon: '/icons/genre.svg',
    title: 'Thể loại',
    route: RouteData.genre,
  ),
  MenuItem(
    icon: '/icons/branch.svg',
    title: 'Chi nhánh',
    route: RouteData.branch,
  ),
  MenuItem(
    icon: '/icons/room.svg',
    title: 'Phòng chiếu',
    route: RouteData.room,
  ),
  MenuItem(
    icon: '/icons/product.svg',
    title: 'Sản phẩm',
    route: RouteData.product,
  ),
  MenuItem(
    icon: '/icons/product.svg',
    title: 'Combo sản phẩm',
    route: RouteData.combo,
  ),
  MenuItem(
    icon: '/icons/showtime.svg',
    title: 'Lịch chiếu',
    route: RouteData.showtime,
  ),
  MenuItem(
    icon: '/icons/ticket.svg',
    title: 'Vé phim',
    route: RouteData.ticket,
  ),
  MenuItem(
    icon: '/icons/trophy.svg',
    title: 'Khuyến mãi',
    route: RouteData.promotion,
  ),
  MenuItem(
    icon: 'assets/icons/advertisement.svg',
    title: 'Quảng cáo',
    route: RouteData.advertisement,
  ),
  MenuItem(
    icon: '/icons/pie-chart.svg',
    title: 'Thống kê',
    route: RouteData.statistic,
  ),
];
