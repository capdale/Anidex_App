import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

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

class UserInfo extends ChangeNotifier {
  String userEmail = '';
  bool isLogined = false;
  User? user;

  changeUserEmail(String s) {
    userEmail = s;
  }

  changeIsLogined(bool b) {
    isLogined = b;
  }

  changeUser(User? u) {
    user = u;
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

class SelectImage with ChangeNotifier {
  var selectedImageId = 0;
  var selectedImageUrl = "https://picsum.photos/id/0/600/600";

  changeSelectedImage(int i) {
    selectedImageId = i;
    selectedImageUrl = "https://picsum.photos/id/$selectedImageId/600/600";
    notifyListeners();
  }
}


class ProfileImage with ChangeNotifier {
  var selectedImageId = 0;
  var selectedImageUrl = "https://picsum.photos/id/0/600/600";

  changeSelectedImage(int i) {
    selectedImageId = i;
    selectedImageUrl = "https://picsum.photos/id/$selectedImageId/600/600";
    notifyListeners();
  }
}