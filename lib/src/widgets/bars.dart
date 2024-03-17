import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/_init.dart' as store;

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {}, icon: Icon(Icons.account_circle), iconSize: 50),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.settings), iconSize: 50)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

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
        currentIndex: context.watch<store.Tabs>().tab,
        onTap: (i) {
          context.read<store.Tabs>().changePage(i);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Index'),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: 'Gallery'),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: '검색',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ),
    );
  }
}

class CustomedSearchBar extends StatelessWidget {
  final bool pinned;

  const CustomedSearchBar({super.key, this.pinned = false});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: pinned,
      flexibleSpace: FlexibleSpaceBar(
        background: SearchBar(),
      ),
      expandedHeight: 10,
    );
  }
}
