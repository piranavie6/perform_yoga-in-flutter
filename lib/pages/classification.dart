/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'alert_page_correct.dart';
import 'alert_page_incorrect.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:math';


class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  List _output = [];
  bool _isModelLoaded = false;
  late Interpreter _interpreter;

  @override
  void initState() {
    super.initState();
    loadModel(); // Load the model when the widget is initialized
  }

  Future<void> loadModel() async {
    try {
      // Create a new interpreter for the model
      _interpreter = await Interpreter.fromAsset('assets/classification_implementation2.tflite');
      /*setState(() {
        _isModelLoaded = true; // Update state to reflect that the model has been loaded
      });*/
      print("Model loaded successfully********************************.");
      setState(() {
        _isModelLoaded = true;
      });
      await _runModel(widget.imageFile); // Pass the image file to _runModel
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<List<double>?> preprocessImage(String imagePath) async {
    try {
      // Load the image using the image package
      print("Loading image from******************: $imagePath");

      var image = img.decodeImage(File(imagePath).readAsBytesSync())!;

      // Resize the image to the required size (e.g., 64x64)
      var resizedImage = img.copyResize(image, width: 64, height: 64);

      // Flatten the image data into a one-dimensional array
      List<double> flattenedImage = [];

      for (int y = 0; y < resizedImage.height; y++) {
        for (int x = 0; x < resizedImage.width; x++) {
          // Get pixel values
          var pixel = resizedImage.getPixel(x, y);
          // Convert ARGB to RGB and flatten it
          flattenedImage.add(img.getRed(pixel) / 255.0); // Red channel
          flattenedImage.add(img.getGreen(pixel) / 255.0); // Green channel
          flattenedImage.add(img.getBlue(pixel) / 255.0); // Blue channel
        }
      }
      return flattenedImage;
    } catch (e) {
      print("Error preprocessing image: $e");
      return null;
    }
  }

  /*Future<void> _runModel(File imageFile) async {

    if (_isModelLoaded) {
      // Preprocess the image before running the model
      print("happy*************************** ");

      var inputImage = await preprocessImage(imageFile.path);
      print("preprocessed********************* ");

      if (inputImage != null) {
        // Prepare the output array based on your model's output shape
        var output = List.filled(1 * 2, 0).reshape([1, 17]); // Adjust shape based on your model output
        _interpreter.run(inputImage, output);

        setState(() {
          _output = output; // Update the output
        });

        // Check the output value
        if (_output.isNotEmpty && _output[0][0] == 0) { // If model returns 0 for correct poses
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AlertPage1Correct()), // Navigate to correct page
          );
        } else if (_output.isNotEmpty && _output[0][0] == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AlertPage1Incorrect()), // Navigate to wrong page
          );
        }
      }
    }
    print("Error 55555555555555555555555555555555555555");

  }*/

  Future<void> _runModel(File imageFile) async {
    if (_isModelLoaded) {
      print("happy*************************** ");

      var inputImage = await preprocessImage(imageFile.path);
      print("Image preprocessed.***********************");

      if (inputImage != null) {
        // Adjust output array shape for 17 classes
        var output = List.filled(1 * 17, 0).reshape([1, 17]);
        _interpreter.run(inputImage, output);

        setState(() {
          _output = output; // Update the output
        });

        // Determine the class with the highest score
        int predictedClass = output[0].indexOf(output[0].reduce(max));
        print("Predicted class: $predictedClass");

        // Update navigation based on predicted class
        if (predictedClass < 5) { // Assuming classes 0-4 are for correct poses
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AlertPage1Correct()), // Navigate to correct page
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AlertPage1Incorrect()), // Navigate to wrong page
          );
        }
      }
    } else {
      print("eror5555555555555555555.");
    }
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Detection'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: _isModelLoaded
            ? const Text('Model loaded, running detection...')
            : const SpinKitThreeBounce(
          color: Colors.black,
          size: 40,
        ),
      ),
    );
  }
}

*/

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'alert_page_correct.dart';
import 'alert_page_incorrect.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:math';
import 'verification.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  List _output = [];
  bool _isModelLoaded = false;
  late Interpreter _interpreter;

  @override
  void initState() {
    super.initState();
    loadModel(); // Load the model when the widget is initialized

  }

  Future<void> loadModel() async {
    try {
      // Create a new interpreter for the model
      _interpreter = await Interpreter.fromAsset('assets/classification_implementation2.tflite');

      print("Model loaded successfully***********************.");
      setState(() {
        _isModelLoaded = true;
      });
      await _runModel(widget.imageFile); // Pass the image file to _runModel
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<List<double>?> preprocessImage(String imagePath) async {
    try {
      print("Loading image from:**************** $imagePath");
      var image = img.decodeImage(File(imagePath).readAsBytesSync())!;

      // Resize the image to the required size (e.g., 64x64)
      var resizedImage = img.copyResize(image, width: 64, height: 64);
      List<double> flattenedImage = [];

      for (int y = 0; y < resizedImage.height; y++) {
        for (int x = 0; x < resizedImage.width; x++) {
          var pixel = resizedImage.getPixel(x, y);
          flattenedImage.add(img.getRed(pixel) / 255.0);
          flattenedImage.add(img.getGreen(pixel) / 255.0);
          flattenedImage.add(img.getBlue(pixel) / 255.0);
        }
      }
      return flattenedImage;
    } catch (e) {
      print("Error preprocessing image: $e");
      return null;
    }
  }



  // Future<void> _runModel(File imageFile) async {
  //   if (_isModelLoaded) {
  //     print("Model is loaded, starting preprocessing...");
  //
  //     var inputImage = await preprocessImage(imageFile.path);
  //     print("Image preprocessed successfully.");
  //     //await loadModel2();
  //
  //     if (inputImage != null) {
  //       // Initialize output with shape [1, 17] to match model's output
  //       var output = List.filled(1 * 17, 0.0).reshape([1, 17]);
  //       _interpreter.run(inputImage, output);
  //
  //       List<double> probabilities = List<double>.from(output[0]);
  //       double maxProb = probabilities.reduce((a, b) => a > b ? a : b);
  //       int predictedIndex = probabilities.indexOf(maxProb);
  //
  //       print("Probabilities: $probabilities");  // Debugging
  //       print("Max probability: $maxProb, Predicted index: $predictedIndex");
  //
  //       // Define the target indices for your monitored poses
  //       const List<int> targetPoseIndices = [0, 1, 2, 3, 4]; // These correspond to "tree", "goddess", "warrior2", "plank", "downdog"
  //
  //       // Classify the pose based on predicted index
  //       int result;
  //       if (maxProb < 0.1 ) { // Threshold to identify an unknown pose
  //         print("Pose classified as unknown/unrelated (below threshold).");
  //
  //         result = 1; // Indicates unknown
  //       } else if (targetPoseIndices.contains(predictedIndex)) {
  //         print("Pose classified as correct (one of the target poses).");
  //         result = 0; // Indicates correct pose
  //       } else {
  //         print("Pose classified as incorrect.");
  //         result = 1; // Indicates incorrect pose
  //       }
  //
  //       // Navigate based on the result
  //       if (result == 0) {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => AlertPage1Correct()),
  //         );
  //       } else {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => AlertPage1Incorrect()),
  //         );
  //       }
  //     } else {
  //       print("Error: Preprocessed image is null.");
  //     }
  //   } else {
  //     print("Model not loaded.");
  //   }
  // }
  //

  Future<void> _runModel(File imageFile) async {
    if (_isModelLoaded) {
      print("Model is loaded, starting preprocessing...");

      var inputImage = await preprocessImage(imageFile.path);
      print("Image preprocessed successfully.");

      if (inputImage != null) {
        // Initialize output with shape [1, 17] to match model's output
        var output = List.filled(1 * 17, 0.0).reshape([1, 17]);
        _interpreter.run(inputImage, output);

        List<double> probabilities = List<double>.from(output[0]);
        double maxProb = probabilities.reduce((a, b) => a > b ? a : b);
        int predictedIndex = probabilities.indexOf(maxProb);

        print("Probabilities: $probabilities");  // Debugging
        print("Max probability: $maxProb, Predicted index: $predictedIndex");

        // Define the target indices for your monitored poses
        const List<int> targetPoseIndices = [0, 1, 2, 3, 4]; // These correspond to "tree", "goddess", "warrior2", "plank", "downdog"

        // Classify the pose based on predicted index and max probability
        int result;

        // Condition 1: If the predicted index is within the target poses (0 to 4) and maxProb is high enough
        if (targetPoseIndices.contains(predictedIndex) && maxProb >= 0.1) {
          print("Pose classified as correct (one of the target poses with sufficient probability).");
          result = 0; // Indicates correct pose
        }
        // Condition 2: If the predicted index is outside of 0 to 4 or maxProb is too low
        else {
          print("Pose classified as incorrect (either unknown or low probability).");
          result = 1; // Indicates incorrect pose
        }

        // Navigate based on the result
        if (result == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AlertPage1Correct()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AlertPage1Incorrect()),
          );
        }
      } else {
        print("Error: Preprocessed image is null.");
      }
    } else {
      print("Model not loaded.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Detection'),
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
