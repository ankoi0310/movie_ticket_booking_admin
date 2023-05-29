final Map<String, String> statisticValue = {
  'REVENUE': 'Tổng doanh thu',
  'BRANCH': 'Doanh thu theo chi nhánh',
  'MOVIE': 'Doanh thu theo phim',
  'TICKET': 'Tổng số vé bán ra',
};

final Map<String, String> statisticTimeline = {
  'DAY': 'Today',
  'WEEK': 'This Week',
  'MONTH': 'This Month',
  'YEAR': 'This Year',
};

// Timeline data
final List<int> timelineDay = List.generate(1, (index) => index + 1);
final List<int> timelineWeek = List.generate(7, (index) => index + 1);
final List<int> timelineMonth = List.generate(30, (index) => index + 1);
final List<int> timelineYear = List.generate(12, (index) => index + 1);
