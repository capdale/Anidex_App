import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:anidex_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;
import 'package:anidex_app/src/providers/providers.dart' as providers;
import 'package:anidex_app/src/model/_init.dart' as model;

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
      List<int> imageBytes = await File(tempfile.path).readAsBytes();
      img.Image? image = img.copyRotate(img.decodeImage(imageBytes)!, 90);

      print(image.width);
      print(image.height);
      var cropSize = min(image.width, image.height);
      int offsetX = (image.width - cropSize) ~/ 2;
      int offsetY = (image.height - cropSize) ~/ 2;
      img.Image cropOne =
          img.copyCrop(image, offsetX, offsetY, cropSize, cropSize);

      final savePhoto = await _analyzePicture(cropOne);
      if (savePhoto != null && savePhoto) {
        Directory directory = Directory('storage/emulated/0/DCIM/anidex_image');
        await Directory(directory.path).create(recursive: true);
        List<int> pngBytes = img.encodePng(cropOne);
        File('${directory.path}/${tempfile.name}').writeAsBytesSync(pngBytes);
      }
      return;
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<bool?> _analyzePicture(imageFile) async {
    model.Net mobileNet = model.Net();
    Map result = await mobileNet.runModel(imageFile);
    String animalName = result['label'];
    const isColletect = 0;
    print(result['id']);
    if (mounted) {
      if (isColletect == 0) {
        // TODO: 도감에 등재하는 함수
        showRegisterDialog(context, animalName);
        return true;
      } else if (isColletect == 1) {
        // 2. 등재된 동물이면 사진 추가
        return await showAddPictureDialog(context, animalName, imageFile);
      } else {
        // 3. 인식 실패
        await showFailDialog(context, imageFile);
        return true;
      }
    }
    return null;
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
                        controller.resumePreview();
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

void showRegisterDialog(BuildContext context, animalName) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$animalName와(과) 친구가 되었다!"),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "도감에 $animalName의 정보가 등록되었습니다.",
              style: TextStyle(fontSize: 20),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                child: Text(
                  "확인",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  context.read<providers.Tabs>().changePage(0);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const App()),
                      (route) => false);
                },
              ),
            ),
          ],
        );
      });
}

Future<bool> showAddPictureDialog(
    BuildContext context, animalName, imageFile) async {
  final response = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "$animalName은(는) 이미 도감에 등록된 동물입니다. 도감에 사진을 추가하시겠습니까?",
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
              showDeletePictureDialog(context);
            },
          ),
          ElevatedButton(
            child: Text(
              "예",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
              // TODO: 도감에 사진 추가
              context.read<providers.Tabs>().changePage(0);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const App()),
                  (route) => false);
            },
          ),
        ],
      );
    },
  );

  return response;
}

void showDeletePictureDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "사진이 저장되지 않고 삭제됩니다.",
            style: TextStyle(fontSize: 20),
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
              "확인",
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
              Navigator.of(context).pop(false);
            },
          ),
        ],
      );
    },
  );
}

Future<void> showFailDialog(BuildContext context, imageFile) async {
  showDialog(
    barrierDismissible: false,
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
    barrierDismissible: false,
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
            child: Column(children: [
              Text(
                "본인이 생각하는 동물의 이름을 제보해 주세요.",
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                controller: controller,
                maxLines: 1,
                style: TextStyle(fontSize: 20),
              )
            ]),
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
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
