import 'package:flutter/material.dart';

var theme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 1,
    color: Colors.white,
    shadowColor: Colors.grey,
    titleTextStyle: TextStyle(color: Colors.black12, fontSize: 30),
    iconTheme: IconThemeData(
      color: Color(0xFF48444E),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 1,
    selectedIconTheme: IconThemeData(
      size: 40
    ),
    unselectedIconTheme: IconThemeData(
      size: 40
    ),
    backgroundColor: Colors.white,
    selectedItemColor: Colors.deepPurple,
    selectedLabelStyle: TextStyle(fontSize: 14),
    unselectedLabelStyle:
        TextStyle(fontSize: 12),
  ),
);
