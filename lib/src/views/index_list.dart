import 'package:flutter/material.dart';

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
        delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            leading: Text('NO. ${(index + 1).toString().padLeft(3, '0')}'),
            title: TextButton(
              onPressed: () {},
              style: ButtonStyle(alignment: Alignment.centerLeft),
              child: Text('???'),
            ),
          );
        }, childCount: 100));
  }
}
