import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/store.dart' as store;

class BotNaviBar extends StatefulWidget {
  const BotNaviBar({super.key});

  @override
  State<BotNaviBar> createState() => _BotNaviBarState();
}

class _BotNaviBarState extends State<BotNaviBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Colors.grey,
              width: 0.7), // Adjust color and width as needed
        ),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: context.watch<store.Pages>().tab,
        onTap: (i) {context.read<store.Pages>().changePage(i);},
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Index'),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Gallery'),
        ],
      ),
    );
  }
}
