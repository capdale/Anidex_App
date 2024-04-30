import 'package:flutter/cupertino.dart';
import 'package:anidex_app/src/widgets/_init.dart' as widgets;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return widgets.captureButton(context);
  }
}
