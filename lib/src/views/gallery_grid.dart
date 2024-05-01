import 'package:flutter/material.dart';
import 'package:anidex_app/src/pages/_init.dart' as pages;

// GalleryGridView
class GalleryGrid extends StatefulWidget {
  const GalleryGrid({super.key});

  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pages.Article(index)),
              );
            },
            child: Hero(
              tag: '$index',
              transitionOnUserGestures: true,
              child: Material(
                type: MaterialType.transparency,
                child: Image(
                  alignment: Alignment.center,
                  image: NetworkImage(
                    "https://picsum.photos/id/$index/600/600",
                  ),
                ),
              ),
            ),
          );
        },
        childCount: 42,
      ),
    );
  }
}