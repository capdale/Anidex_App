import 'package:flutter/material.dart';
import 'package:anidex_app/src/widgets/_init.dart' as widgets;
import 'package:anidex_app/src/views/_init.dart' as views;

class Article extends StatelessWidget {
  final int index;
  Article(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widgets.DefaultAppBar(
          title: 'ANIDEX',
        ),
        body: views.ArticleView(index));
  }
}
