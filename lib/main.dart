import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'style.dart' as style;
import 'store.dart' as store;
import 'widget.dart' as widget;

void main() {
  runApp(ChangeNotifierProvider(
      create: (c) => store.Pages(),
      child: MaterialApp(theme: style.mainTheme, home: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
            onPressed: () {}, icon: Icon(Icons.account_circle), iconSize: 50),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings), iconSize: 50)
        ],
      ),
      body: [
        Text('index'),
        widget.CaptureButton(),
        Text('gallery')
      ][context.watch<store.Pages>().tab],
      bottomNavigationBar: widget.BotNaviBar(),
    );
  }
}
