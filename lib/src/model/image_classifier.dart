// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
// import 'package:image/image.dart';
// import 'package:path/path.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
//
// class ImageClassifier {
//   late ImagePicker imagePicker;
//   File? _image;
//   String result = '';
//
//   dynamic imageLabeler;
//
//   @override
//   void initState() {
//     super.initState();
//     imagePicker = ImagePicker();
//     createLabeler();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     imageLabeler.close();
//   }
//
//   Future<void> createLabeler() async {
//     final modelPath =
//         await getModelPath('assets/ml/mobilenetv3-large-100-224-fp32.tflite');
//     final options = LocalLabelerOptions(
//       confidenceThreshold: 0.3,
//       modelPath: modelPath,
//     );
//   }
//
//   Future<String> getModelPath(String asset) async {
//     final path = "${(await getApplicationSupportDirectory()).path}/$asset";
//     await Directory(dirname(path)).create(recursive: true);
//     final file = File(path);
//     if (!await file.exists()) {
//       final byteData = await rootBundle.load(asset);
//       await file.writeAsBytes(byteData.buffer
//           .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//     }
//     return file.path;
//   }
//
//   Future<void> doImageLabeling() async {
//     var result = "";
//     final inputImage = InputImage.fromFile(_image!);
//     final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
//     print(labels);
//     for (ImageLabel label in labels) {
//       final String text = label.label;
//       final int index = label.index;
//       final double confidence = label.confidence;
//       result += "$text   ${confidence.toStringAsFixed(2)}\n";
//     }
//     setState(() {
//       result;
//     });
//   }
// }
