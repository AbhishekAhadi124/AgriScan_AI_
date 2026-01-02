import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class ClassifierService {
  Interpreter? gatekeeperInterpreter, diseaseInterpreter;
  List<String>? gatekeeperLabels, diseaseLabels;
  bool isInitialized = false;

  Future<void> initialize() async {
    if (isInitialized) return;
    gatekeeperInterpreter = await Interpreter.fromAsset(
      'assets/gatekeeper.tflite',
    );
    diseaseInterpreter = await Interpreter.fromAsset(
      'assets/plant_disease.tflite',
    );
    gatekeeperLabels = await loadLabels('assets/gatekeeper_labels.txt');
    diseaseLabels = await loadLabels('assets/labels.txt');
    isInitialized = true;
  }

  Future<List<String>> loadLabels(String assetPath) async {
    final data = await rootBundle.loadString(assetPath);
    return data
        .split('\n')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  Future<String> processImage(File imageFile) async {
    final rawBytes = await imageFile.readAsBytes();
    final img.Image? fullImage = img.decodeImage(rawBytes);
    if (fullImage == null) return "Error: Failed to decode image.";
    final gateResized = img.copyResize(fullImage, width: 1, height: 1);
    var gateInput = imageToByteList(gateResized, 1);
    var gateOutput = List.filled(1000, 0.0).reshape([1, 1000]);
    gatekeeperInterpreter?.run(gateInput, gateOutput);
    int gateIdx = getHighestProbIndex(List<double>.from(gateOutput[0]));
    String gateLabel = '${gatekeeperLabels?[gateIdx]}';
    bool isPlant = validatePlantCategory(gateLabel);
    if (!isPlant) {
      return "INVALID_PLANT: This looks like a $gateLabel. Please upload a plant image.";
    }
    final diseaseResized = img.copyResize(fullImage, width: 224, height: 224);
    var diseaseInput = imageToByteList(diseaseResized, 224);
    var diseaseOutput = List.filled(38, 0.0).reshape([1, 38]);

    diseaseInterpreter!.run(diseaseInput, diseaseOutput);
    int diseaseIdx = getHighestProbIndex(diseaseOutput[0]);

    return diseaseLabels![diseaseIdx].replaceAll('_', ' ');
  }

  Uint8List imageToByteList(img.Image image, int size) {
    var convertedBytes = Float32List(1 * size * size * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < size; i++) {
      for (var j = 0; j < size; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = pixel.r / 255.0;
        buffer[pixelIndex++] = pixel.g / 255.0;
        buffer[pixelIndex++] = pixel.b / 255.0;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  int getHighestProbIndex(List<double> probabilities) {
    int maxIdx = 0;
    double maxProb = -1.0;
    for (int i = 0; i < probabilities.length; i++) {
      if (probabilities[i] > maxProb) {
        maxProb = probabilities[i];
        maxIdx = i;
      }
    }
    return maxIdx;
  }

  bool validatePlantCategory(String label) {
    final lowerLabel = label.toLowerCase();
    const plantKeywords = [
      'leaf',
      'plant',
      'tree',
      'broccoli',
      'corn',
      'cucumber',
      'pepper',
      'potato',
      'strawberry',
      'tomato',
      'zucchini',
      'apple',
    ];
    return plantKeywords.any((keyword) => lowerLabel.contains(keyword));
  }
}
