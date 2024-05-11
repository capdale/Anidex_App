import 'package:flutter/material.dart';
import 'package:anidex_app/src/widgets/_init.dart' as widgets;
import 'package:anidex_app/src/views/_init.dart' as views;
import 'package:anidex_app/src/providers/_init.dart' as providers;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class UploadImgView extends StatefulWidget {
  UploadImgView({super.key});

  @override
  State<UploadImgView> createState() => _UploadImgViewState();
}

class _UploadImgViewState extends State<UploadImgView> {

  Widget _imagePreview(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final selectedImageId = context.watch<providers.SelectImage>().selectedImageId;
    return SizedBox(
        width: width,
        height: width,
        child: Image.network(
                "https://picsum.photos/id/$selectedImageId/${width.toInt()}/${width.toInt()}")
            );
  }

  Widget _header(BuildContext context) {
    final firstCamera = context.read<providers.CameraProvider>().camera;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            '나의 사진',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
        ),
        Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                ),
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
                icon: Icon(
                  size: 30,
                  Icons.camera_alt_outlined,
                  color: Color(0xffF7F6FA),
                )))
      ]),
    );
  }

  Widget _imageSelectList(BuildContext context) {
    var width = MediaQuery.of(context).size.width.toInt();
    var selectedImageId = context.watch<providers.SelectImage>().selectedImageId;
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          var imageUrl = "https://picsum.photos/id/$index/$width/$width";
          return GestureDetector(
            onTap: () {
              setState(() {
                context.read<providers.SelectImage>().changeSelectedImage(index);
              });
            },
            child: Opacity(
              opacity: selectedImageId == index ? 0.6 : 1.0,
              child: Image(
                alignment: Alignment.center,
                image: NetworkImage(imageUrl),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _imagePreview(context),
          _header(context),
          _imageSelectList(context),
        ],
      ),
    );
  }
}

class UploadPostView extends StatelessWidget {
  const UploadPostView({super.key});


  @override
  Widget build(BuildContext context) {
    final selectedImageUrl = context.watch<providers.SelectImage>().selectedImageUrl;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: width,
            height: width,
            child: Image.network(selectedImageUrl),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "내용을 입력해 주세요.",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              widgets.DynamicAutoCompleteTags(),
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
