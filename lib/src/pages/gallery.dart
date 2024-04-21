import 'package:flutter/material.dart';
import 'package:anidex_app/src/widgets/_init.dart' as widgets;
import 'package:anidex_app/src/views/_init.dart' as views;

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  var scrollCheck = ScrollController();

  getData() async {
    // TODO: 스크롤 끝까지 내렸을 때 서버로부터 게시물 새로 불러오는 함수 구현해야 함
  }

  @override
  void initState() {
    super.initState();
    scrollCheck.addListener(() {
      if (scrollCheck.position.pixels == scrollCheck.position.maxScrollExtent) {
        getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(controller: scrollCheck, slivers: <Widget>[
        widgets.CustomedSearchBar(pinned: false),
        views.GalleryGrid(),
      ]),
      floatingActionButton: widgets.WriteButton(),
    );
  }
}
