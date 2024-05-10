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
      var imageFile = await FlutterNativeImage.cropImage(
          tempfile.path, offsetX, offsetY, cropSize, cropSize);

      Directory directory = Directory('storage/emulated/0/DCIM/MyImages');
      await Directory(directory.path).create(recursive: true);
      await File(imageFile.path).copy('${directory.path}/${tempfile.name}');
    } catch (e) {
      print('Error taking picture: $e');
    }
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
                    // 버튼 클릭 이벤트 정의를 위한 GestureDetector
                    child: GestureDetector(
                      onTap: () {
                        // 사진 찍기 함수 호출
                        _takePicture();
                      },
                      // 버튼으로 표시될 Icon
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
