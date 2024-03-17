import 'package:flutter/material.dart';

class GalleryGridView extends StatefulWidget {
  const GalleryGridView({super.key});

  @override
  State<GalleryGridView> createState() => _GalleryGridViewState();
}
class _GalleryGridViewState extends State<GalleryGridView> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 0, // Spacing between items
        mainAxisSpacing: 0, // Spacing between rows
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.blue[100 * (index % 9)],
            child: Text('Grid Item $index'),
          );
        },
        childCount: 42, // Number of items in the grid
      ),
    );
  }
}
