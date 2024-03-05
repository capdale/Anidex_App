import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/theme/_init.dart' as style;
import 'src/store/_init.dart' as store;
import 'src/widgets/_init.dart' as widgets;
import 'src/pages/_init.dart' as pages;

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
        pages.Home(),
        Text('gallery')
      ][context.watch<store.Pages>().tab],
      bottomNavigationBar: widgets.BotNaviBar(),
    );
  }
}
