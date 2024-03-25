import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentPanel extends StatefulWidget {
  const CommentPanel({super.key});

  @override
  State<CommentPanel> createState() => _CommentPanelState();
}

class _CommentPanelState extends State<CommentPanel> {
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
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  size: 30,
                ))
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
