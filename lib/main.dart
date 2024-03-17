import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/theme/_init.dart' as style;
import 'src/store/_init.dart' as store;
import 'src/widgets/_init.dart' as widgets;
import 'src/pages/_init.dart' as pages;

void main() {
  runApp(ChangeNotifierProvider(
      create: (c) => store.Tabs(),
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
    final tabIndex = context.watch<store.Tabs>().tab;

    return Scaffold(
      appBar: tabIndex == 1 ? widgets.MyAppBar() : null,
      body: [
        pages.Index(),
        pages.Home(),
        pages.Gallery()
      ][tabIndex],
      bottomNavigationBar: widgets.BotNaviBar(),
    );
  }
}
