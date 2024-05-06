import 'package:flutter/material.dart';
import 'package:anidex_app/src/app.dart';
import 'package:anidex_app/src/pages/_init.dart' as pages;

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    bool login = false;
    if (login) {
      return const App();
    } else {
      return const pages.Login();
    }
  }
}
