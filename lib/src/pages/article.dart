import 'package:flutter/material.dart';
import '../widgets/_init.dart' as widgets;
import '../views/_init.dart' as views;

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
