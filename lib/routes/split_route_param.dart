List<String> getRouteParams(String routeName) {
  List<String> temp = [];
  temp = routeName.split('/');
  return temp;
}
