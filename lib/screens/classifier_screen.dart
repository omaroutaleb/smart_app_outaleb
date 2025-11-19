import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:math'; // For exp()

class ClassifierScreen extends StatefulWidget {
  @override
  _ClassifierScreenState createState() => _ClassifierScreenState();
}

class _ClassifierScreenState extends State<ClassifierScreen> {
  File? _image;
  String _result = "";
  double _confidence = 0.0;
  Interpreter? interpreter;
  List<String> labels = [];

  @override
  void initState() {
    super.initState();
    loadModel();
    loadLabels();
  }

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/model/model.tflite');
  }

  Future<void> loadLabels() async {
    final String raw = await DefaultAssetBundle.of(context).loadString('assets/model/labels.txt');
    labels = raw.split('\n').map((l) => l.trim()).toList();
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() => _image = File(image.path));
      await runModelOnImage(File(image.path));
    }
  }

  List<double> softmax(List<double> logits) {
    final expList = logits.map((l) => exp(l)).toList();
    final sumExp = expList.reduce((a, b) => a + b);
    return expList.map((e) => e / sumExp).toList();
  }

  Future<void> runModelOnImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    img.Image? oriImage = img.decodeImage(bytes);
    img.Image resizedImage = img.copyResize(oriImage!, width: 32, height: 32);

    var input = List.generate(1, (i) => List.generate(32, (j) => List.generate(32, (k) => List.filled(3, 0.0))));
    for (int y = 0; y < 32; y++) {
      for (int x = 0; x < 32; x++) {
        final pixel = resizedImage.getPixelSafe(x, y);
        input[0][y][x][0] = pixel.r / 255.0;
        input[0][y][x][1] = pixel.g / 255.0;
        input[0][y][x][2] = pixel.b / 255.0;
      }
    }

    var output = List.filled(labels.length, 0.0).reshape([1, labels.length]);
    interpreter?.run(input, output);

    List<double> logits = List<double>.from(output[0]);
    List<double> probabilities = softmax(logits);

    int maxIdx = 0;
    double maxProb = probabilities[0];
    for (int i = 1; i < probabilities.length; i++) {
      if (probabilities[i] > maxProb) {
        maxProb = probabilities[i];
        maxIdx = i;
      }
    }

    setState(() {
      _result = labels[maxIdx];
      _confidence = maxProb;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fruits Classifier')),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            if (_image != null) Image.file(_image!, height: 180),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera"),
                  onPressed: () => pickImage(ImageSource.camera),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton.icon(
                  icon: Icon(Icons.photo),
                  label: Text("Gallery"),
                  onPressed: () => pickImage(ImageSource.gallery),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_result.isNotEmpty)
              Card(
                color: Colors.green[50],
                child: ListTile(
                  title: Text('Fruit : $_result', style: TextStyle(fontSize: 22)),
                  subtitle: Text('Confiance : ${(100*_confidence).toStringAsFixed(2)}%'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}