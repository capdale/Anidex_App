import 'package:flutter/cupertino.dart';

class Tabs extends ChangeNotifier {
  var tab = 1;
  changePage(i) {
    tab = i;
    notifyListeners();
  }
}