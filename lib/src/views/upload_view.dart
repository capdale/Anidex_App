import 'package:flutter/material.dart';
import 'package:anidex_app/src/widgets/_init.dart' as widgets;

class UploadImgView extends StatefulWidget {
  final Function(String) updateImgUrl;
  UploadImgView({super.key, required this.updateImgUrl});

  @override
  State<UploadImgView> createState() => _UploadImgViewState();
}

class _UploadImgViewState extends State<UploadImgView> {
  String? _selectedImageUrl;
  int? _selectedIndex = 0;

  Widget _imagePreview(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
        width: width,
        height: width,
        child: _selectedImageUrl == null
            ? Image.network(
                "https://picsum.photos/id/0/${width.toInt()}/${width.toInt()}")
            : Image.network(_selectedImageUrl!));
  }

  Widget _header() {
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
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff808080),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              color: Color(0xffF7F6FA),
            ))
      ]),
    );
  }

  Widget _imageSelectList(BuildContext context) {
    var width = MediaQuery.of(context).size.width.toInt();
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
                _selectedImageUrl = imageUrl;
                _selectedIndex = index;
              });
              widget.updateImgUrl(imageUrl);
            },
            child: Opacity(
              opacity: _selectedIndex == index ? 0.6 : 1.0,
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
          _header(),
          _imageSelectList(context),
        ],
      ),
    );
  }
}

class UploadPostView extends StatelessWidget {
  const UploadPostView({super.key, this.selectedImgUrl});
  final selectedImgUrl;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: width,
            height: width,
            child: Image.network(
                selectedImgUrl),
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
