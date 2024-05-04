import 'package:flutter/material.dart';
import 'package:anidex_app/src/pages/_init.dart' as pages;
import 'package:permission_handler/permission_handler.dart';

Widget captureButton(BuildContext context) {
  return Center(
    child: Transform.scale(
      scale: 6.0,
      child: FloatingActionButton(
        onPressed: () async {
          var status = await Permission.camera.status;
          if (status.isGranted) {
            print('허락됨');
          } else if (status.isDenied) {
            print('거절됨');
            Permission.camera.request();
          }
        },
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

Widget writeButton(BuildContext context) {
  return SizedBox(
    height: 70.0,
    width: 70.0,
    child: FittedBox(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => pages.UploadImg()));
        },
        backgroundColor: Colors.deepPurpleAccent,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 32.0),
      ),
    ),
  );
}

class ChangeProfileButton extends StatelessWidget {
  const ChangeProfileButton({super.key, this.formName});

  final String? formName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width, 50)),
        onPressed: () => _showConfirmationDialog(context),
        child: Text(
          '${formName ?? ''} 변경',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Text(
            "정말로 변경하시겠습니까?",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurpleAccent),
              child: Text(
                "아니오",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // 팝업 닫기
              },
            ),
            ElevatedButton(
              child: Text(
                "예",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                // '네' 버튼을 눌러도 아무 일도 일어나지 않게 설정
                Navigator.of(context).pop(); // 옵셔널: 팝업 닫기
              },
            ),
          ],
        );
      },
    );
  }
}
