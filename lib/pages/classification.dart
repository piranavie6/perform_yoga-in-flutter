/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'verification.dart';
import 'not_our_pose.dart';


class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
   bool _isModelLoaded = false;
  late Interpreter _interpreter;

  @override
  void initState() {
    super.initState();
    loadModel(); // Load the model when the widget is initialized

  }
/*
  Future<void> loadModel() async {
    try {
      // Create a new interpreter for the model
      // _interpreter = await Interpreter.fromAsset('assets/classification_implementation2.tflite');//correct classification
      _interpreter = await Interpreter.fromAsset('assets/classification_reset_model.tflite');


      print("Model loaded successfully***********************.");
      setState(() {
        _isModelLoaded = true;
      });
      await _classifyImage(widget.imageFile); // Pass the image file to _runModel
    } catch (e) {
      print("Error loading model: $e");
    }
  }

*/
  Future<void> loadModel() async {
    try {
      String? result = await Tflite.loadModel(
        model: "assets/classification_reset_model.tflite",
        labels: "assets/labels.txt", // Ensure you provide the correct path to your label file
      );
      if (result != null) {
        print("Model loaded successfully: $result");
        setState(() {
          _isModelLoaded = true;
        });
      }
    } catch (e) {
      print("Error loading model: $e");
    }
  }


/*
  Future<List<double>?> preprocessImage(String imagePath) async {
    try {
      print("Loading image from:2222222222222222222222 $imagePath");
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
            MaterialPageRoute(builder: (context) => PoseVerificationPage(imageFile: imageFile)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NotMonitoredPosePage()),
          );
        }
      } else {
        print("Error: Preprocessed image is null.");
      }
    } else {
      print("Model not loaded.");
    }
  }
*/

  Future<void> _classifyImage(File imageFile) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: imageFile.path,
        numResults: 1, // Top prediction only
        threshold: 0.7, // Confidence threshold
        imageMean: 0.0, // Normalization mean
        imageStd: 255.0, // Normalization std
      );

      if (output != null && output.isNotEmpty) {
        String detectedPose = output[0]['label'] as String;

        // Navigate based on model output
        if (detectedPose.toLowerCase() == "Unknown/Unrelated pose") {
          _navigateToNotMonitoredPosePage();
        } else {
          _navigateToPoseVerificationPage(imageFile);
        }
      } else {
        _showError("No valid pose detected. Try again.");
      }
    } catch (e) {
      print("Error classifying image: $e");
      _showError("An error occurred while processing the image.");
    }
  }

  void _navigateToNotMonitoredPosePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotMonitoredPosePage(),
      ),
    );
  }

  void _navigateToPoseVerificationPage(File imageFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PoseVerificationPage(imageFile: imageFile),
      ),
    );
  }
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
*/


/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'verification.dart';
import 'not_our_pose.dart';


class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  bool _isModelLoaded = false;
  late Interpreter _interpreter;

  @override
  void initState() {
    super.initState();
    loadModel(); // Load the model when the widget is initialized

  }


  Future<void> loadModel() async {
    try {
      String? result = await Tflite.loadModel(
        model: "assets/classification_reset_model.tflite",
        labels: "assets/labels.txt", // Ensure you provide the correct path to your label file
      );
      if (result != null) {
        print("Model loaded successfully: $result");
        setState(() {
          _isModelLoaded = true;
        });
      }
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  Future<void> _classifyImage(File imageFile) async {
    try {
      var output = await Tflite.runModelOnImage(
        path: imageFile.path,
        numResults: 1, // Top prediction only
        threshold: 0.7, // Confidence threshold
        imageMean: 0.0, // Normalization mean
        imageStd: 255.0, // Normalization std
      );

      if (output != null && output.isNotEmpty) {
        String detectedPose = output[0]['label'] as String;

        // Navigate based on model output
        if (detectedPose.toLowerCase() == "Unknown/Unrelated pose") {
          _navigateToNotMonitoredPosePage();
        } else {
          _navigateToPoseVerificationPage(imageFile);
        }
      } else {
        _showError("No valid pose detected. Try again.");
      }
    } catch (e) {
      print("Error classifying image: $e");
      _showError("An error occurred while processing the image.");
    }
  }

  void _navigateToNotMonitoredPosePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotMonitoredPosePage(),
      ),
    );
  }

  void _navigateToPoseVerificationPage(File imageFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PoseVerificationPage(imageFile: imageFile),
      ),
    );
  }
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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

 */

/*
import 'dart:io';
import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'verification.dart';
import 'not_our_pose.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  bool _isModelLoaded = false;
  late Interpreter _interpreter;

  @override
  void initState() {
    super.initState();
    loadModel(); // Load the model when the widget is initialized
  }
  /// Loads the TFLite model
  Future<void> loadModel() async {
    try {
      // Load the model
      final interpreterOptions = InterpreterOptions()..threads = 4;
      _interpreter = await Interpreter.fromAsset("assets/classification_reset_model.tflite", options: interpreterOptions);

      print("Model loaded successfully***************");
      setState(() {
        _isModelLoaded = true;
        _classifyImage(widget.imageFile); // Classify the image after loading the model
      });
    } catch (e) {
      print("Error loading model-----------: $e");
    }
  }

  /// Preprocesses the image
  Future<List<List<List<List<double>>>>> preprocessImage(File imageFile) async {
    // Implement the necessary preprocessing for the image (resize, normalization, etc.)
    // You can use the `image` package or any other method suitable for preprocessing
    // For example:
    final img.Image image = img.decodeImage(await imageFile.readAsBytes())!;
    img.Image resized = img.copyResize(image, width: 224, height: 224); // Assuming 224x224 input size
    List<List<List<List<double>>>> input = resized.getBytes().map((byte) => byte / 255.0).toList(); // Example normalization
    return input;
  }

  /*
  /// Classifies the input image and navigates based on the result
  Future<void> _classifyImage(File imageFile) async {
    if (!_isModelLoaded) {
      _showError("Model is not loaded yet.");
      return;
    }

    try {
      var output = await Tflite.runModelOnImage(
        path: imageFile.path,
        numResults: 1, // Get the top prediction only
        threshold: 0.7, // Confidence threshold
        imageMean: 0.0, // Normalization mean
        imageStd: 255.0, // Normalization standard deviation
      );

      if (output != null && output.isNotEmpty) {
        String detectedPose = output[0]['label'] as String;

        // Navigate based on model output
        if (detectedPose.toLowerCase() == "unknown/unrelated pose") {
          _navigateToNotMonitoredPosePage();
        } else {
          _navigateToPoseVerificationPage(imageFile);
        }
      } else {
        _showError("No valid pose detected. Try again.");
      }
    } catch (e) {
      print("Error classifying image: $e");
      _showError("An error occurred while processing the image.");
    }
  }
*/


  /// Classifies the input image and navigates based on the result
  Future<void> _classifyImage(File imageFile) async {
    try {
      // Preprocess the image
      final input = await preprocessImage(imageFile);

      // Prepare output buffer
      final output = List.filled(17, 0.0).reshape([1, 17]);

      // Run inference
      _interpreter.run(input, output);

      // Process the output
      final probabilities = List<double>.from(output[0]);
      final maxIndex = probabilities.indexOf(probabilities.reduce((a, b) => a > b ? a : b));
      final confidence = probabilities[maxIndex];

      // Define mapping for 17 outputs to 6 categories
      const poseMapping = {
        0: "plank",
        1: "downdog",
        2: "warrior2",
        3: "tree",
        4: "goddess",
        5: "unknown/unrelated",
        6: "unknown/unrelated",
        7: "unknown/unrelated",
        8: "unknown/unrelated",
        9: "unknown/unrelated",
        10: "unknown/unrelated",
        11: "unknown/unrelated",
        12: "unknown/unrelated",
        13: "unknown/unrelated",
        14: "unknown/unrelated",
        15: "unknown/unrelated",
        16: "unknown/unrelated",
      };

      // Map the prediction to a pose category
      final detectedPose = poseMapping[maxIndex] ?? "unknown/unrelated";

      print("Detected Pose: $detectedPose with confidence $confidence");

      // Check confidence threshold and navigate
      if (detectedPose == "unknown/unrelated" || confidence < 0.7) {
        _navigateToNotMonitoredPosePage();
      } else {
        _navigateToPoseVerificationPage(imageFile);
      }
    } catch (e) {
      print("Error classifying image: $e");
      _showError("An error occurred during pose detection.");
    }
  }

  /// Navigates to the page for unrelated poses
  void _navigateToNotMonitoredPosePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotMonitoredPosePage(),
      ),
    );
  }

  /// Navigates to the pose verification page
  void _navigateToPoseVerificationPage(File imageFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PoseVerificationPage(imageFile: imageFile),
      ),
    );
  }

  /// Displays an error message using a Snackbar
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Detection'),
      ),
      body: Center(
        child: _isModelLoaded
            ? const SpinKitThreeBounce(
          color: Colors.black,
          size: 40,
        )
            : const Text("Loading Model..."),
      ),
    );
  }
}
*/


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'verification.dart';
import 'not_our_pose.dart';
import 'alert_page_correct.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key, required this.imageFile});
  final File imageFile;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  bool _isModelLoaded = false;
  late Interpreter _interpreter;


  @override
  void initState() {
    super.initState();
    loadModel(); // Load the model when the widget is initialized

  }

  /*/// Loads the TFLite model and labels
  Future<void> loadModel() async {
    try {
      String? result = await Tflite.loadModel(
        model: "assets/classification_reset_model.tflite",
        labels: "assets/labels.txt", // Ensure this path is correct
      );

      if (result != null) {
        print("Model loaded successfully:------------------------------- $result");
        setState(() {
          _isModelLoaded = true;
          _classifyImage(widget.imageFile); // Pass the image file to _runModel
        });
      }
    } catch (e) {
      print("Error loading model++++++++++++++++++++++++++++++++++++++: $e");
    }
  }
*/
  /// Loads the TFLite model
  Future<void> loadModel() async {
    try {
      // Initialize the interpreter with tflite_flutter
      _interpreter = await Interpreter.fromAsset('assets/classification_reset_model.tflite');
      print("Model loaded successfully.");

      setState(() {
        _isModelLoaded = true;
        _classifyImage(widget.imageFile); // Classify the image after model is loaded
      });
    } catch (e) {
      print("Error loading model: $e");
    }
  }
  /// Preprocess the image by resizing and converting it into a 1D array
  Future<List<double>> preprocessImage(File imageFile) async {
    try {
      // Load image from file
      img.Image image = img.decodeImage(imageFile.readAsBytesSync())!;

      // Resize the image to the required input size (224x224 for example)
      img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

      // Flatten the image into a 1D array and normalize the pixel values
      List<double> input = [];
      for (int y = 0; y < resizedImage.height; y++) {
        for (int x = 0; x < resizedImage.width; x++) {
          var pixel = resizedImage.getPixel(x, y);
          input.add(img.getRed(pixel) / 255.0);  // Normalize Red channel
          input.add(img.getGreen(pixel) / 255.0); // Normalize Green channel
          input.add(img.getBlue(pixel) / 255.0);  // Normalize Blue channel
        }
      }
      return input;
    } catch (e) {
      print("Error preprocessing image: $e");
      return [];
    }
  }

  /// Classifies the input image and navigates based on the result
  Future<void> _classifyImage(File imageFile) async {
    if (!_isModelLoaded) {
      _showError("Model is not loaded yet.");
      return;
    }

    try {
      // Preprocess the image
      final input = await preprocessImage(imageFile);
      print("well preprocessed");

      // If the image is not processed correctly, return
      if (input.isEmpty) {
        _showError("Error processing image.");
        return;
      }

      // Prepare output buffer (17 categories for your model)
      final output = List.filled(12 * 17, 0.0).reshape([12, 17]);

      // Run inference
      _interpreter.run(input, output);

      // Process the output/*
      // final probabilities = List<double>.from(output);
      // final maxIndex = probabilities.indexOf(probabilities.reduce((a, b) => a > b ? a : b));
      // final confidence = probabilities[maxIndex];

      // Flatten the 2D output (12, 17) to 1D for further processing
      final probabilities = output.expand((e) => e).toList();

      // Process the output as before
      final maxIndex = probabilities.indexOf(probabilities.reduce((a, b) => a > b ? a : b));
      final confidence = probabilities[maxIndex];

      // Define mapping for 17 outputs to 6 categories
      const poseMapping = {
        0: "plank",
        1: "downdog",
        2: "warrior2",
        3: "tree",
        4: "goddess",
        5: "unknown/unrelated",
        6: "unknown/unrelated",
        7: "unknown/unrelated",
        8: "unknown/unrelated",
        9: "unknown/unrelated",
        10: "unknown/unrelated",
        11: "unknown/unrelated",
        12: "unknown/unrelated",
        13: "unknown/unrelated",
        14: "unknown/unrelated",
        15: "unknown/unrelated",
        16: "unknown/unrelated",
      };

      // Map the prediction to a pose category
      final detectedPose = poseMapping[maxIndex] ?? "unknown/unrelated";

      print("Detected Pose: $detectedPose with confidence $confidence");

      // Check confidence threshold and navigate
      if (confidence < 0.15 ) {
        print("Navigating to NotMonitoredPosePage");
        _navigateToNotMonitoredPosePage();

      } else {
        print("Navigating to verificatonn Page");

        _navigateToPoseVerificationPage(imageFile);
      }
    } catch (e) {
      print("Error classifying image: $e");
      _showError("An error occurred during pose detection.");
    }
  }

  /// Navigates to the page for unrelated poses
  void _navigateToNotMonitoredPosePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotMonitoredPosePage(),
      ),
    );
  }

  /// Navigates to the pose verification page
  void _navigateToPoseVerificationPage(File imageFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
       // builder: (context) => PoseVerificationPage(imageFile: imageFile),
        builder: (context) => AlertPage1Correct(),

      ),
    );
  }

  /// Displays an error message using a Snackbar
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Detection'),
      ),
      body: Center(
        child: _isModelLoaded
            ? const SpinKitThreeBounce(
          color: Colors.black,
          size: 40,
        )
            : const Text("Loading Model..."),
      ),
    );
  }
}
