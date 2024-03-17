import 'package:flutter/cupertino.dart';
import '../widgets/_init.dart' as widgets;

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return widgets.SearchBar();
  }
}
