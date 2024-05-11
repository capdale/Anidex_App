import 'package:anidex_app/src/providers/_init.dart' as providers;
import 'package:anidex_app/src/Root.dart';
import 'package:flutter/material.dart';
import 'package:anidex_app/src/pages/_init.dart' as pages;
import 'package:anidex_app/src/views/_init.dart' as views;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Widget captureButton(BuildContext context) {
  final firstCamera = context.read<providers.CameraProvider>().camera;

  return Center(
    child: Transform.scale(
      scale: 6.0,
      child: FloatingActionButton(
        onPressed: () async {
          var status = await Permission.camera.status;
          if (status.isGranted) {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => views.CaptureScreen(
                          camera: firstCamera!,
                        )),
              );
            }
          } else if (status.isDenied) {
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => pages.UploadImg()));
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
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                "예",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Widget signOutButton(BuildContext context) {
  void showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Text(
            "정말로 탈퇴하시겠습니까?\n사라진 데이터는 복구할 수 없습니다.",
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
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                "예",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                // TODO: Session 만료 및 회원정보 삭제
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Root()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  return TextButton(
      onPressed: () {
        showSignOutDialog(context);
      },
      child: Text(
        '회원 탈퇴',
        style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 18,
            color: Colors.grey),
      ));
}
