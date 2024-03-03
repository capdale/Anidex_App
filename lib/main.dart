import 'package:flutter/material.dart';
import 'style.dart' as s;
import 'widgets.dart' as w;

void main() {
  runApp(MaterialApp(theme: s.theme, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.account_circle), iconSize: 50),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings), iconSize: 50)
        ],
      ),
      body: w.CaptureButton(),
      bottomNavigationBar: w.BotNaviBar(),
    );
  }
}
