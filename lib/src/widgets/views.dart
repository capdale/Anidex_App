import 'package:flutter/material.dart';
import '../pages/_init.dart' as pages;
import '../widgets/_init.dart' as widgets;

// GalleryGridView
class GalleryGridView extends StatefulWidget {
  const GalleryGridView({super.key});

  @override
  State<GalleryGridView> createState() => _GalleryGridViewState();
}

class _GalleryGridViewState extends State<GalleryGridView> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 0, // Spacing between items
        mainAxisSpacing: 0, // Spacing between rows
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pages.Article(index)),
              );
            },
            child: Hero(
              tag: '$index',
              transitionOnUserGestures: true,
              child: Material(
                type: MaterialType.transparency,
                child: Image(
                  alignment: Alignment.center,
                  image: NetworkImage(
                    "https://picsum.photos/id/$index/300/300",
                  ),
                ),
              ),
            ),
          );
        },
        childCount: 42, // Number of items in the grid
      ),
    );
  }
}

// IndexListView
class IndexListView extends StatefulWidget {
  const IndexListView({super.key});

  @override
  State<IndexListView> createState() => _IndexListViewState();
}

class _IndexListViewState extends State<IndexListView> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return ListTile(
        leading: Text('NO. ${(index + 1).toString().padLeft(3, '0')}'),
        title: TextButton(
          onPressed: () {},
          style: ButtonStyle(alignment: Alignment.centerLeft),
          child: Text('???'),
        ),
      );
    }, childCount: 100));
  }
}

// ArticleView
class ArticleView extends StatefulWidget {
  final int index;

  const ArticleView(this.index, {super.key});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: '${widget.index}',
        transitionOnUserGestures: true,
        child: Material(
          type: MaterialType.transparency,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widgets.AuthorBar(),
                Image.network(
                  "https://picsum.photos/id/${widget.index}/600/600",
                  fit: BoxFit.cover,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: Text(
                    '달은 지금 긴 산허리에 걸려 있다. 밤중을 지난 무렵인지 죽은 듯이 고요한 속에서 짐승 같은 달의 숨소리가 손에 잡힐 듯이 들리며, 콩 포기와 옥수수 잎새가 한층 달에 푸르게 젖었다. 산허리는 온통 메밀밭이어서 피기 시작한 꽃이 소금을 뿌린 듯이 흐뭇한 달빛에 숨이 막힐 지경이다.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700),
                        '2024.01.01 12:34')),
                widgets.FavoriteAndShareButton(),
                widgets.CommentBar(),
                widgets.CommentPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
