import 'package:flutter/material.dart';
import 'package:anidex_app/src/app.dart';
import 'package:anidex_app/src/pages/_init.dart' as pages;
import 'package:anidex_app/src/providers/_init.dart' as providers;
import 'package:provider/provider.dart';

class Root extends StatelessWidget {

  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLogined = context.watch<providers.UserInfo>().isLogined;
    if (isLogined) {
      return const App();
    } else {
      return pages.Login();
    }
  }
}
