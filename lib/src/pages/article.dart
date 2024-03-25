import 'package:flutter/material.dart';
import '../widgets/_init.dart' as widgets;

class Article extends StatelessWidget {
  final int index;
  Article(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widgets.DefaultAppBar(
          title: 'ANIDEX',
        ),
        body: widgets.ArticleView(index));
  }
}
