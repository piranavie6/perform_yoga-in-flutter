import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'pages/alert_page_correct.dart'; // Import your correct alert page
import 'pages/alert_page_incorrect.dart'; // Import your incorrect alert page
import 'package:flutter_tflite/flutter_tflite.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  List _output = [];
  bool _isModelLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    print("Loading model...");
    await Tflite.loadModel(
      model: "assets/yoga_pose_model.tflite", // Update this path if necessary
      labels: "assets/yoga_labels.txt", // Update this path if necessary
    ).then((result) {
      print("Model loaded: $result");
      setState(() {
        _isModelLoaded = true;
      });
      
    }).catchError((error) {
      print("Error loading model: $error");
    });
  }

  Future<void> _runModel() async {
    if (_isModelLoaded) {
      var output = await Tflite.runModelOnImage(
        path: widget.imageFile.path,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 5, // Number of results to return
        threshold: 0.6,
      );
      setState(() {
        _output = output ?? [];
      });

      // Navigate based on the classification result
      if (_output.isNotEmpty && _output[0]['index'] == 0) {
        // Assuming index 0 is a correct identification
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AlertPage1Correct()),
        );
      } else {
        // If not identified as a correct pose
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AlertPage1Incorrect()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Run the model after the UI is built
    if (_isModelLoaded) {
      _runModel();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Detection'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: const SpinKitThreeBounce(
          color: Colors.black,
          size: 40,
        ),
      ),
    );
  }
}
