final Map<String, String> statisticValue = {
  'revenue': 'Tổng doanh thu',
  'revenue-per-branch': 'Doanh thu theo chi nhánh',
  'revenue-per-movie': 'Doanh thu theo phim',
  'ticket': 'Tổng số vé bán ra',
};

final Map<String, String> statisticTimeline = {
  'day': 'Today',
  'week': 'This Week',
  'month': 'This Month',
  'year': 'This Year',
};

// Timeline data
final List<int> timelineDay = List.generate(1, (index) => index + 1);
final List<int> timelineWeek = List.generate(7, (index) => index + 1);
final List<int> timelineMonth = List.generate(30, (index) => index + 1);
final List<int> timelineYear = List.generate(12, (index) => index + 1);
