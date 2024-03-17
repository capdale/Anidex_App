import 'package:flutter/material.dart';
import '../widgets/_init.dart' as widgets;

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  var scrollCheck = ScrollController();

  getData() async {}

  @override
  void initState() {
    super.initState();
    scrollCheck.addListener(() {
      if (scrollCheck.position.pixels == scrollCheck.position.maxScrollExtent) {
        getData() async {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(controller: scrollCheck, slivers: <Widget>[
        widgets.GallerySearchBar(),
        widgets.GalleryGridView(),
      ]),
      floatingActionButton: widgets.WriteButton(),
    );
  }
}
