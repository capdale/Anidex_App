import 'package:anidex_app/src/root.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/theme/_init.dart' as style;
import 'src/store/_init.dart' as store;

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (create) => store.Tabs()),
    ChangeNotifierProvider(create: (create) => store.UserEmail()),
  ], child: MaterialApp(theme: style.mainTheme, home: const Root())));
}
