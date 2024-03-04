import 'package:flutter/cupertino.dart';

class Pages extends ChangeNotifier {
  var tab = 1;
  changePage(i) {
    tab = i;
    notifyListeners();
  }
}