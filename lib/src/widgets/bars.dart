import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anidex_app/src/store/_init.dart' as store;
import 'package:anidex_app/src/pages/_init.dart' as pages;

// HomeAppBar
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => pages.Settings(),
                    fullscreenDialog: true));
          },
          icon: Icon(Icons.account_circle),
          iconSize: 50),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.settings), iconSize: 50)
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

// BotNaviBar
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

//SearchBar
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

// CustomedSearchBar
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

//DefaultAppBar
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key, this.title, this.showActions = true});

  final title;
  final bool showActions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          iconSize: 30),
      title: Text(
        title ?? '',
        style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700
            ),
      ),
      centerTitle: true,
      actions: showActions ? [
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert), iconSize: 30)
      ] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

// AuthorBar
class AuthorBar extends StatelessWidget {
  const AuthorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Row(
        children: [
          Icon(
            Icons.account_circle,
            size: 40,
          ),
          SizedBox(width: 8),
          Text(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              '오늘내일한다'),
        ],
      ),
    );
  }
}

// CommentBar
class CommentBar extends StatelessWidget {
  const CommentBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 50,
      alignment: Alignment.center,
      color: Colors.deepPurple[300],
      child: Text(
        '댓글',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}


//TitleBar
class TitleBar extends StatelessWidget {
  final int? indexNum;
  const TitleBar({super.key, this.indexNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              'No. ${((indexNum ?? 0) + 1).toString().padLeft(3, '0')}'),
          SizedBox(width: 8),
          Text(
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              '오늘내일한다'),
        ],
      ),
    );
  }
}