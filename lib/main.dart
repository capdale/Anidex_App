import 'package:anidex_app/src/root.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/theme/_init.dart' as style;
import 'src/providers/_init.dart' as providers;

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (create) => providers.Tabs()),
    ChangeNotifierProvider(create: (create) => providers.UserEmail()),
  ], child: MaterialApp(theme: style.mainTheme, home: const Root())));
}
