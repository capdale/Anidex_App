import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anidex_app/src/providers/_init.dart' as providers;
import 'package:anidex_app/src/pages/_init.dart' as pages;
import 'package:anidex_app/src/widgets/_init.dart' as widgets;

// HomeAppBar
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => pages.Profile(),
                    fullscreenDialog: true));
          },
          child: Image.asset(
            'assets/images/default_profile.png',
          ),
        ),
      ),
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
          top: BorderSide(color: Colors.grey, width: 0.7),
        ),
      ),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: context.watch<providers.Tabs>().tab,
        onTap: (i) {
          context.read<providers.Tabs>().changePage(i);
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
Widget searchBar(BuildContext context) {
  return SizedBox(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: '검색',
          hintStyle: TextStyle(fontSize: 20),
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
        background: searchBar(context),
      ),
      expandedHeight: 10,
    );
  }
}

//DefaultAppBar
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar(
      {super.key,
      this.title,
      this.barColor,
      this.showActions = true,
      this.elevation = true});

  final title;
  final barColor;
  final bool showActions;
  final bool elevation;
  final bool articleOwn = true;

  @override
  Widget build(BuildContext context) {
    var e = 0.0;
    if (elevation) {
      e = 1.0;
    } else {
      e = 0.0;
    }
    return AppBar(
      backgroundColor: barColor,
      surfaceTintColor: barColor,
      elevation: e,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          iconSize: 30),
      title: Text(
        title ?? '',
        style: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      actions: showActions
          ? [
              widgets.articleMenu(context, 30, articleOwn),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

AppBar uploadImgBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.close),
        iconSize: 30),
    title: Text(
      '사진 업로드',
      style: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
    ),
    centerTitle: true,
    actions: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(5)),
        child: TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => pages.UploadPost(),
                      fullscreenDialog: false));
            },
            child: Text(
              '다음',
              style: TextStyle(
                  color: Color(0xFFF7F6FA),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )),
      )
    ],
  );
}

AppBar uploadPostBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
        iconSize: 30),
    title: Text(
      '새 게시물',
      style: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
    ),
    centerTitle: true,
    actions: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(5)),
        child: TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: Text(
              '등록',
              style: TextStyle(
                  color: Color(0xFFF7F6FA),
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            )),
      )
    ],
  );
}

// AuthorBar
Widget authorBar(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(12.0),
    child: Row(
      children: [
        Image.asset(
          'assets/images/default_profile.png',
          width: 40,
          height: 40,
        ),
        SizedBox(width: 8),
        Text(
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            '오늘내일한다'),
      ],
    ),
  );
}

// CommentBar
Widget commentBar(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(8.0),
    height: 50,
    alignment: Alignment.center,
    color: Colors.deepPurple[300],
    child: Text(
      'Comment',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

//TitleBar
class TitleBar extends StatelessWidget {
  final int? indexNum;

  const TitleBar({super.key, this.indexNum});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff777777)),
                'No. ${((indexNum ?? 0) + 1).toString().padLeft(3, '0')}'),
            SizedBox(width: 8),
            Text(
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff9451D2)),
                '까치'),
          ],
        ),
      ),
    );
  }
}
