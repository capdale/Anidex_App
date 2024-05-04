import 'package:flutter/material.dart';
import 'package:anidex_app/src/widgets/_init.dart' as widgets;
import 'package:anidex_app/src/views/_init.dart' as views;

class UploadImg extends StatefulWidget {
  const UploadImg({super.key});

  @override
  State<UploadImg> createState() => _UploadImgState();
}

class _UploadImgState extends State<UploadImg> {
  String selectedImgUrl = "";

  void updateImgUrl(String newData) {
    setState(() {
      selectedImgUrl = newData;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.uploadImgBar(context, selectedImgUrl),
      body: views.UploadImgView(updateImgUrl: updateImgUrl)
    );
  }
}

class UploadPost extends StatelessWidget {
  const UploadPost({super.key, this.selectedImgUrl});
  final selectedImgUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widgets.uploadPostBar(context),
        body: views.UploadPostView(selectedImgUrl: selectedImgUrl,)
    );
  }
}