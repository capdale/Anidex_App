import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

class Net {
  late Interpreter _interpreter;
  late List<String> _labels;
  final imageSize = 224;
  final labelSize = 1000;
  TensorImage tensorImage = TensorImage();

  Future<List<String>> _loadModel() async {
    _interpreter = await Interpreter.fromAsset(
        'assets/ml/mobilenetv3-large-100-224-fp32.tflite');
    final labelsData = await rootBundle
        .loadString('assets/ml/mobilenetv3-large-100-224-fp32_label.txt');
    final labels = labelsData.split('\n');
    return labels;
  }

  Future<void> _preprocessImage(imageFile) async {
    ImageProcessor imageProcessor = ImageProcessorBuilder()
        .add(ResizeOp(imageSize, imageSize, ResizeMethod.nearestneighbour))
        .build();
    tensorImage.loadImage(imageFile);
    tensorImage = imageProcessor.process(tensorImage);
  }

  Future<List> _getInput() async {
    List<List<List<int>>> input = List.generate(
      imageSize,
      (y) => List.generate(
        imageSize,
        (x) {
          final pixel = tensorImage.image.getPixel(x, y);
          return [
            img.getRed(pixel),
            img.getGreen(pixel),
            img.getBlue(pixel),
          ];
        },
      ),
    );
    return [input];
  }

  List<double> _runInference(input) {
    var output = List.filled(labelSize + 1, 0.0).reshape([1, labelSize + 1]);
    _interpreter.run(input, output);
    print('run model');
    return output[0];
  }

  Map<String, dynamic> _getTopLabel(int maxIndex) {
    final result = {
      'id': maxIndex,
      'label': _labels[maxIndex],
    };
    return result;
  }

  Future<Map> runModel(imageFile) async {
    _labels = await _loadModel();
    await _preprocessImage(imageFile);
    final input = await _getInput();
    final output = _runInference(input);
    int maxIndex = _findMaxIndex(output);
    final result = _getTopLabel(maxIndex);
    return result;
  }
}


int _findMaxIndex(List<double> lst) {
  int maxIndex = 0;
  double maxValue = lst[0];

  for (int i = 1; i < lst.length; i++) {
    if (lst[i] > maxValue) {
      maxValue = lst[i];
      maxIndex = i;
    }
  }
  return maxIndex;
}
