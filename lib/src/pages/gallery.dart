import 'package:flutter/cupertino.dart';
import '../widgets/_init.dart' as widgets;

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return widgets.SearchBar();
  }
}
