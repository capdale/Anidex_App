import 'package:flutter/material.dart';
import '../widgets/_init.dart' as widgets;
import '../views/_init.dart' as views;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.DefaultAppBar(
        title: "프로필",
        showActions: false,
      ),
      body: views.SettingsView(),
    );
  }
}
