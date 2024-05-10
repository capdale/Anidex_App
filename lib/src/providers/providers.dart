import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

class Tabs extends ChangeNotifier {
  var tab = 1;
  changePage(i) {
    tab = i;
    notifyListeners();
  }
}

class ContentInfo extends ChangeNotifier {
  var indexNum = 0;
  var current = 0;
  var gridImageList = [];
  changeIndexNum(int i) {
    indexNum = i;
  }
  changeCurrent(int c) {
    current = c;
    notifyListeners();
  }
  setGridImageList(List<String> imgList) {
    gridImageList = imgList;
  }
}


class UserEmail extends ChangeNotifier {
  var userEmail = '';
  changeUserEmail(String s) {
    userEmail = s;
  }
}

class CameraProvider with ChangeNotifier {
  CameraDescription? _camera;

  CameraDescription? get camera => _camera;

  void setCamera(CameraDescription camera) {
    _camera = camera;
    notifyListeners();
  }
}