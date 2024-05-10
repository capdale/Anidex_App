import 'package:anidex_app/src/widgets/_init.dart' as widgets;
import 'package:anidex_app/src/theme/_init.dart' as theme;
import 'package:anidex_app/src/views/_init.dart' as views;
import 'package:flutter/material.dart';

class CommentPanel extends StatefulWidget {
  const CommentPanel({super.key});

  @override
  State<CommentPanel> createState() => _CommentPanelState();
}

class _CommentPanelState extends State<CommentPanel> {
  final commentOwn = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
              child: Wrap(
                spacing: 8.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  Text(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      'seoultech21')
                ],
              ),
            ),
            widgets.commentMenu(context, 30, commentOwn),
          ]),
          Container(
            padding: EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(style: TextStyle(fontSize: 18), 'Test Comment'),
                SizedBox(height: 5),
                Text(
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                    '2024.12.30. 23:56'),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

Widget profileTable(
    BuildContext context, String nickname, String email, String introduction) {
  return Container(
    decoration: theme.tableDecoration(2, 5),
    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
    child: Table(
      children: [
        widgets.profileTableRow(
            context, '닉네임', nickname, views.ChangeNickName(nickname: nickname)),
        widgets.profileTableRow(context, '대표 이메일', 'User1234@naver.com',
            views.ChangeEmail(email: email)),
        widgets.profileTableRow(context, '연동된 소셜 계정', 'User1234', null),
        // Placeholder for onTap
        widgets.profileTableRow(context, '소개', introduction,
            views.ChangeIntroduction(introduction: introduction)),
      ],
    ),
  );
}

Widget contentTable(BuildContext context) {
  return Container(
      decoration: theme.tableDecoration(2, 12),
      margin: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
      child: Table(
        children: [
          TableRow(
              children: [widgets.contentRow(context, '학명', 'Pica serica')]),
          TableRow(children: [
            widgets.contentRow(context, '영문명', 'Oriental Magpie')
          ]),
          TableRow(
            children: [widgets.contentCategory(context)],
          ),
          TableRow(
              children: [widgets.contentRow(context, '멸종위기등급', 'Pica serica')]),
          TableRow(
              children: [widgets.contentRow(context, '만난 날짜', '2024-04-22')]),
          TableRow(
              children: [widgets.contentRow(context, '만난 장소', 'xxx, yyy')]),
        ],
      ));
}
