import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:anidex_app/src/providers/_init.dart' as providers;
import 'package:anidex_app/src/widgets/_init.dart' as widgets;

class ContentView extends StatefulWidget {
  final indexNum;

  const ContentView({super.key, this.indexNum});

  @override
  State<ContentView> createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  @override
  Widget build(BuildContext context) {
    context.read<providers.ContentInfo>().changeIndexNum(widget.indexNum);
    var imgList = [
      "https://picsum.photos/id/${context.watch<providers.ContentInfo>().indexNum}/600/600",
      "https://picsum.photos/id/${context.watch<providers.ContentInfo>().indexNum + 1}/600/600",
      "https://picsum.photos/id/${context.watch<providers.ContentInfo>().indexNum + 2}/600/600",
      "https://picsum.photos/id/${context.watch<providers.ContentInfo>().indexNum + 3}/600/600"
    ];
    context.read<providers.ContentInfo>().setGridImageList(imgList);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          widgets.TitleBar(
            indexNum: context.watch<providers.ContentInfo>().indexNum,
          ),
          SizedBox(height: 5),
          SizedBox(
              height: 600,
              child: Stack(
                children: [
                  widgets.sliderWidget(context, (newIndex) {
                    setState(() {
                      context.read<providers.ContentInfo>().changeCurrent(newIndex);
                    });
                  }),
                  widgets.sliderIndicator(context),
                ],
              )),
          SizedBox(height: 30),
          widgets.contentTable(context),
          Container(
              padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
              child: Text(
                textAlign: TextAlign.justify,
                "까치는 매우 똑똑한 조류로, 거울 앞에서 자신을 인식할 수 있는 몇 안 되는 동물 중 하나이다. 복잡한 사회적 구조를 가지고 있으며, 다른 까치와 긴밀한 관계를 유지하면서 그룹 내에서 의사소통을 한다. 또한, 까치는 반짝이는 물건을 수집하며, 자신의 영역을 장식하기 위해 다양한 물건을 사용한다는 연구 결과가 있다.",
                style: TextStyle(fontSize: 22),
              )),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
