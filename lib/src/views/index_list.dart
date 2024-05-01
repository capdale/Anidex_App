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
      return SizedBox(
        height: 80,
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal:12, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.deepPurple[300],
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              'No. ${(indexNum + 1).toString().padLeft(3, '0')}',
              style: TextStyle(
                  fontFamily: 'D2Coding',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          title: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => pages.Content(indexNum: indexNum),
                      fullscreenDialog: false));
            },
            style: ButtonStyle(alignment: Alignment.centerLeft),
            child: Text('---', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.black)),
          ),
        ),
      );
    }, childCount: 12));
  }
}
