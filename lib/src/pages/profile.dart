import 'package:flutter/material.dart';
import 'package:anidex_app/src/widgets/_init.dart' as widgets;
import 'package:anidex_app/src/views/_init.dart' as views;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.DefaultAppBar(
        title: "프로필",
        showActions: false,
      ),
      body: views.ProfileView(),
    );
  }
}
