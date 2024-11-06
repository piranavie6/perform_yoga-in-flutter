import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'alert_page_correct.dart';
import 'alert_page_incorrect.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:math';
import 'classification.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key, required this.imageFile}) : super(key: key);
  final File imageFile;

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  List _output = [];
  bool _isModel2Loaded = false;
  late Interpreter _interpreter;

  @override
  void initState() {
    super.initState();
     loadModel2(); // Load the model when the widget is initialized
  }

   Future<void> loadModel2() async {
    try {
      // Create a new interpreter for the model
      _interpreter = await Interpreter.fromAsset('assets/verification.tflite');
      print("Model loaded successfully.");
      setState(() {
        _isModel2Loaded = true;
      });
      //await _runModel(widget.imageFile); // Pass the image file to _runModel
    } catch (e) {
      print("Error loading model: $e");
    }
  }
/*
  Future<void> _runModel(File imageFile) async {
    // Load the image and preprocess it
    var image = img.decodeImage(imageFile.readAsBytesSync())!;
    var inputImage = preprocessImage(image);
    var output = List.filled(1, 0).reshape([1, 1]); // Assuming binary output

    _interpreter.run(inputImage, output);

    setState(() {
      _output = output;
    });

    if (_output[0][0] == 0) {
      // Navigate to the correct page if the output is 0
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlertPageCorrect()),
      );
    } else {
      // Navigate to the incorrect page if the output is 1
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlertPageIncorrect()),
      );
    }
  }

  List preprocessImage(img.Image image) {
    // Resize the image to match the model's input requirements
    final resizedImage = img.copyResize(image, width: 224, height: 224);

    // Normalize pixel values
    return resizedImage
        .getBytes()
        .map((pixel) => pixel / 255.0)
        .toList()
        .reshape([1, 224, 224, 3]);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Detection'),
      ),
      body: Center(
        child: _isModel2Loaded
            ? const Text('Model Loaded, Running Detection...')
            : const SpinKitThreeBounce(
          color: Colors.black,
          size: 40,
        ),
      ),
    );
  }
}
