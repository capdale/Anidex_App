import 'package:flutter/material.dart';

class UploadImgView extends StatelessWidget {
  const UploadImgView({super.key});

  Widget _imagePreview(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        color: Colors.grey);
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'My Collection',
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

  Widget _imageSelectList() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blue[index % 9 * 100],
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
          _imageSelectList(),
        ],
      ),
    );
  }
}
