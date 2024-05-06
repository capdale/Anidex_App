import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anidex_app/src/store/_init.dart' as store;
import 'package:anidex_app/src/widgets/_init.dart' as widgets;
import 'package:anidex_app/src/pages/_init.dart' as pages;

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final tabIndex = context.watch<store.Tabs>().tab;

    return Scaffold(
      appBar: tabIndex == 1 ? widgets.HomeAppBar() : null,
      body: [
        pages.Index(),
        pages.Home(),
        pages.Gallery()
      ][tabIndex],
      bottomNavigationBar: widgets.BotNaviBar(),
    );
  }
}