import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  State<CaptureScreen> createState() => CaptureScreenState();
}

class CaptureScreenState extends State<CaptureScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.max,
        enableAudio: false);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("CameraController Error : CameraAccessDenied");
            break;
          default:
            print("CameraController Error");
            break;
        }
      }
    });
  }

  Future<void> _takePicture() async {
    if (!controller.value.isInitialized) {
      return;
    }

    try {
      final XFile tempfile = await controller.takePicture();

      ImageProperties properties =
          await FlutterNativeImage.getImageProperties(tempfile.path);
      var cropSize = min(properties.width!, properties.height!);
      int offsetX = (properties.width! - cropSize) ~/ 2;
      int offsetY = (properties.height! - cropSize) ~/ 2;
      final imageFile = await FlutterNativeImage.cropImage(
          tempfile.path, offsetX, offsetY, cropSize, cropSize);
      await _analyzePicture(imageFile);
      Directory directory = Directory('storage/emulated/0/DCIM/MyImages');
      await Directory(directory.path).create(recursive: true);
      await File(imageFile.path).copy('${directory.path}/${tempfile.name}');
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _analyzePicture(imageFile) async {
    // 1. 등재되지 않은 동물이면 자동 등재

    // 2. 등재된 동물이면 사진 추가

    // 3. 인식 실패
    showFailDialog(context, imageFile);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        await controller.dispose();
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
        body: Stack(children: [
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRect(
                child: Transform.scale(
                  scale: controller.value.aspectRatio,
                  child: Center(
                    child: CameraPreview(controller),
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 3,
                color: Color.fromRGBO(0, 0, 0, 0.8),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.pausePreview();
                        _takePicture();
                      },
                      child: const Icon(
                        Icons.camera_enhance_rounded,
                        size: 80,
                        color: Colors.white,
                      ),
                    )),
              )),
        ]),
      ),
    );
  }
}


void showFailDialog(BuildContext context, imageFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "인식에 실패하였습니다.\n동물을 제보하시겠습니까?",
            style: TextStyle(fontSize: 20),
          ),
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
              showAnimalReportDialog(context, imageFile);
            },
          ),
        ],
      );
    },
  );
}


void showAnimalReportDialog(BuildContext context, imageFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final controller = TextEditingController();
      return AlertDialog(
        backgroundColor: Colors.white,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: SizedBox(
            height: 120,
            width: 80,
            child: Column(
              children: [Text(
                "본인이 생각하는 동물의 이름을 제보해 주세요.",
                style: TextStyle(fontSize: 20),
              ), TextField(
                controller: controller,
                maxLines: 1,
                style: TextStyle(fontSize: 20),
              )]
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurpleAccent),
            child: Text(
              "취소",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text(
              "제출",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              print(controller.text);
              print(imageFile);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
