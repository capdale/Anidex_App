import 'package:flutter/material.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 6.0,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          shape: CircleBorder(
            side: BorderSide(color: Colors.deepPurple, width: 2.0),
          ),
          child: Text(
            'CAPTURE',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 30.0,
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WriteButton extends StatelessWidget {
  const WriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      width: 70.0,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Colors.deepPurpleAccent,
          shape: CircleBorder(),
          child: Icon(Icons.edit),
        ),
      ),
    );
  }
}

class FavoriteAndShareButton extends StatefulWidget {
  const FavoriteAndShareButton({super.key});

  @override
  State<FavoriteAndShareButton> createState() => _FavoriteAndShareButtonState();
}

class _FavoriteAndShareButtonState extends State<FavoriteAndShareButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.deepPurple, width: 2)),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8.0,
          children: <Widget>[
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_outline,
                  size: 40,
                )),
            Text(
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                '좋아요 8,765개'),
            SizedBox(width: 4),
            SizedBox(
              width: 15,
              height: 35,
              child: VerticalDivider(
                color: Colors.deepPurple,
                thickness: 2,
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  size: 40,
                )),
          ],
        ),
      ),
    );
  }
}

