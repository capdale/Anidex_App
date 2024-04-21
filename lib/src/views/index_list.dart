import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anidex_app/src/pages/_init.dart' as pages;

// IndexListView
class IndexList extends StatefulWidget {
  const IndexList({super.key});

  @override
  State<IndexList> createState() => _IndexListState();
}

class _IndexListState extends State<IndexList> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, indexNum) {
      return ListTile(
        leading: Text('NO. ${(indexNum + 1).toString().padLeft(3, '0')}', style: TextStyle(fontSize: 18),),
        title: TextButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => pages.Content(indexNum: indexNum),
                    fullscreenDialog: false));
          },
          style: ButtonStyle(alignment: Alignment.centerLeft),
          child: Text('???', style: TextStyle(fontSize: 20)),
        ),
      );
    }, childCount: 100));
  }
}
