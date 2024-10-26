import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:camera/camera.dart'; // For XFile

// Declare the interpreter as a global variable
Interpreter? interpreter;

// Load the TensorFlow Lite model
Future<void> loadModel() async {
  try {
    interpreter = await Interpreter.fromAsset('assets/yoga_pose_model.tflite');
    print('Model loaded successfully.');
  } catch (e) {
    print('Error loading model: $e');
  }
}

// Preprocess the captured image and classify it
Future<String> predictPose(XFile image) async {
  // Read the image bytes
  final bytes = await image.readAsBytes();

  // Decode the image and resize it to the required size (e.g., 64x64)
  final originalImage = img.decodeImage(bytes);
  final resizedImage = img.copyResize(originalImage!, width: 64, height: 64);

  // Normalize and flatten the image for model input
  final input = preprocessImage(resizedImage);

  // Call the model for classification and return the result
  return await classifyImage(input);
}

// Normalize and format the image data to fit the model input format
List<List<List<double>>> preprocessImage(img.Image image) {
  final width = image.width;
  final height = image.height;

  List<List<List<double>>> input = List.generate(
    height,
        (y) => List.generate(
      width,
          (x) {
        final pixel = image.getPixel(x, y);
        final r = img.getRed(pixel) / 255.0;
        final g = img.getGreen(pixel) / 255.0;
        final b = img.getBlue(pixel) / 255.0;
        return [r, g, b]; // Return normalized RGB values
      },
    ),
  );

  return input;
}



// Run the model and classify the processed image
Future<String> classifyImage(List<List<List<double>>> image) async {
  if (interpreter == null) {
    print('Interpreter is not initialized.');
    return 'Interpreter not initialized';
  }

  // Define output shape based on your model’s output structure
  var output = List.filled(5, 0.0).reshape([1, 5]); // Adjust this shape as per model specs

  // Run the interpreter with the input image and output buffer
  interpreter!.run(image, output);

  // Process the output to get the predicted pose label
  return processOutput(output[0]);
}

// Process model output to determine the predicted label
String processOutput(List<double> output) {
  // Find the index with the highest confidence
  int highestConfidenceIndex = 0;
  double highestConfidenceValue = output[0];

  for (int i = 1; i < output.length; i++) {
    if (output[i] > highestConfidenceValue) {
      highestConfidenceValue = output[i];
      highestConfidenceIndex = i;
    }
  }

  // Map the index to actual pose names if available, e.g., ['Tree', 'Warrior', ...]
  List<String> poseLabels = ['Tree Pose', 'Warrior Pose', 'Downward Dog', 'Cobra Pose', 'Mountain Pose'];
  return poseLabels[highestConfidenceIndex]; // Return predicted pose label
}
