import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:anidex_app/src/store/_init.dart' as store;
import 'package:provider/provider.dart';

TableRow settingTableRow(
    BuildContext context, String label, String value, Widget? route) {
  return TableRow(
    children: [
      InkWell(
        onTap: () {
          if (route != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => route));
          }
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 20, 5, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              Row(
                children: [
                  Text(value,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600)),
                  Icon(Icons.chevron_right, color: Colors.grey, size: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Row contentRow(BuildContext context, String label, String value) {
  final padding = EdgeInsets.only(left: 20, top: 20, bottom: 20);
  return Row(children: [
    Flexible(
      flex: 4,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: padding,
        child:
            Text(label, style: TextStyle(fontSize: 22, color: Colors.black54)),
      ),
    ),
    Flexible(
      flex: 6,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: padding,
        child: Text(value, style: TextStyle(fontSize: 22)),
      ),
    )
  ]);
}

Widget contentCategory(BuildContext context) {
  return Theme(
    data: ThemeData().copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      tilePadding: EdgeInsets.fromLTRB(20, 5, 15, 5),
      title: Text('분류', style: TextStyle(fontSize: 22, color: Colors.black54)),
      initiallyExpanded: false,
      children: [
        categoryPadding('계', '동물계(Animalia)'),
        categoryPadding('문', '척삭동물문(Chordata)'),
        categoryPadding('강', '조강(Aves)'),
        categoryPadding('목', '참새목(Passeriformes)'),
        categoryPadding('과', '까마귀과(Corvidae)'),
        categoryPadding('속', '까치속(Pica)'),
        categoryPadding('종', '동양까치(P. serica)'),
      ],
    ),
  );
}

Row categoryPadding(String key, String value) {
  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Container(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text(
              key,
              style: TextStyle(fontSize: 20, color: Colors.black54),
            )),
      ),
      Expanded(
        flex: 8,
        child: Container(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text(
              value,
              style: TextStyle(fontSize: 20),
            )),
      )
    ],
  );
}

Widget sliderWidget(BuildContext context, Function(int) onPageChangedCallback) {
  return CarouselSlider(
      items: context.watch<store.ContentInfo>().imageList.map((imgLink) {
        return Builder(
          builder: (context) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      imgLink,
                    )));
          },
        );
      }).toList(),
      options: CarouselOptions(
          height: 600,
          viewportFraction: 1.0,
          autoPlay: false,
          onPageChanged: (index, reason) {
            onPageChangedCallback(index);
          }));
}

Widget sliderIndicator(BuildContext context) {
  final CarouselController controller = CarouselController();
  return Align(
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: context
          .watch<store.ContentInfo>()
          .imageList
          .asMap()
          .entries
          .map((entry) {
        return GestureDetector(
            onTap: () => controller.animateToPage(entry.key),
            child: Container(
              width: 10,
              height: 10,
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(
                    context.watch<store.ContentInfo>().current == entry.key
                        ? 0.9
                        : 0.4),
              ),
            ));
      }).toList(),
    ),
  );
}
