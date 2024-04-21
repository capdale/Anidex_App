import 'package:anidex_app/src/store/_init.dart' as store;
import 'package:anidex_app/src/widgets/_init.dart' as widgets;
import 'package:anidex_app/src/views/_init.dart' as views;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Content extends StatefulWidget {
  final indexNum;
  const Content({super.key, this.indexNum});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => store.ContentInfo(),
      child: Scaffold(
          appBar: widgets.DefaultAppBar(
            showActions: false,
          ),
          body: views.ContentView(indexNum: widget.indexNum)),
    );
  }
}
