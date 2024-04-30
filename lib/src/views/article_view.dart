import 'package:flutter/material.dart';
import 'package:anidex_app/src/widgets/_init.dart' as widgets;

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
                widgets.authorBar(context),
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
                widgets.FavoriteAndShare(),
                widgets.commentBar(context),
                widgets.CommentPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}