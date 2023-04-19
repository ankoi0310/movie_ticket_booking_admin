import 'package:flutter/cupertino.dart';

class LoadingProvider extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
