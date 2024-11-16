/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PoseVerification extends StatefulWidget {
  final File imageFile; // Add the imageFile parameter

  // Constructor to accept the image file
  PoseVerification({required this.imageFile});

  @override
  _PoseVerificationState createState() => _PoseVerificationState();
}

class _PoseVerificationState extends State<PoseVerification> {
  Interpreter? interpreter;

  @override
  void initState() {
    super.initState();
    _loadVerificationModel();
  }

  // Load the verification model
  Future<void> _loadVerificationModel() async {
    try {
      interpreter = await Interpreter.fromAsset('verification.tflite');
      print("Model loaded successfully!");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  @override
  void dispose() {
    interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pose Verification')),
      body: Center(
        child: interpreter == null
            ? CircularProgressIndicator()  // Show loading if model not loaded
            : Text('Model Loaded!'),        // Display a message once the model is ready
      ),
    );
  }
}


 ********
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PoseVerification extends StatefulWidget {
  final File imageFile;  // Add this line to define the imageFile parameter

  // Constructor to accept the imageFile parameter
  PoseVerification({required this.imageFile});

  @override
  _PoseVerificationState createState() => _PoseVerificationState();
}

class _PoseVerificationState extends State<PoseVerification> {
  Interpreter? interpreter;

  @override
  void initState() {
    super.initState();
    _loadVerificationModel();
  }

  // Load the verification model
  Future<void> _loadVerificationModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/verification_select_ops.tflite');
      print("Model loaded successfully!");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  @override
  void dispose() {
    interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pose Verification')),
      body: Center(
        child: interpreter == null
            ? CircularProgressIndicator()  // Show loading if model not loaded
            : Text('Model Loaded!'),        // Display message when model is ready
      ),
    );
  }
}

*/
//
// import 'package:flutter/material.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'dart:io';
//
// class PoseVerification extends StatefulWidget {
//   final File imageFile;  // The image you want to verify
//
//   PoseVerification({required this.imageFile});
//
//   @override
//   _PoseVerificationState createState() => _PoseVerificationState();
// }
//
// class _PoseVerificationState extends State<PoseVerification> {
//   Interpreter? interpreter;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadModel();
//   }
//
//   // Load the TensorFlow Lite model
//   Future<void> _loadModel() async {
//     try {
//       //interpreter = await Interpreter.fromAsset('assets/let_verify.tflite');
//             interpreter = await Interpreter.fromAsset('assets/model.tflite');
//       print("Model loaded successfully!");
//     } catch (e) {
//       print("Error loading model: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     interpreter?.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Pose Verification')),
//       body: Center(
//         child: interpreter == null
//             ? CircularProgressIndicator()  // Show loading while the model is loading
//             : Text('Model Loaded!'),        // Show once model is loaded
//       ),
//     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// //import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';  // Import for Flex delegate
// import 'dart:io';
//
// class PoseVerification extends StatefulWidget {
//   final File imageFile;
//
//   PoseVerification({required this.imageFile});
//
//   @override
//   _PoseVerificationState createState() => _PoseVerificationState();
// }
//
// class _PoseVerificationState extends State<PoseVerification> {
//   Interpreter? interpreter;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadModel();
//   }
//
//   // Load the TensorFlow Lite model with the Flex delegate
//   Future<void> _loadModel() async {
//     try {
//       // Configure interpreter options with Flex Delegate for unsupported ops
//       final interpreterOptions = InterpreterOptions()..addDelegate(TfLiteDelegate.flex());
//
//       // Load the TFLite model with the specified options
//       _interpreter = await Interpreter.fromAsset('assets/model.tflite', options: interpreterOptions);
//       print("Model loaded successfully!");
//     } catch (e) {
//       print("Error loading model: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     interpreter?.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Pose Verification')),
//       body: Center(
//         child: interpreter == null
//             ? CircularProgressIndicator()  // Show loading while the model is loading
//             : Text('Model Loaded!'),        // Show once model is loaded
//       ),
//     );
//   }
// }
/*
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:io';

class PoseVerification extends StatefulWidget {
  final File imageFile;

  PoseVerification({required this.imageFile});

  @override
  _PoseVerificationState createState() => _PoseVerificationState();
}

class _PoseVerificationState extends State<PoseVerification> {
  Interpreter? _interpreter;

  @override
  void initState() {
    super.initState();
    loadModel();
  }


  Future<void> loadModel() async {
    try {
      // Define the interpreter options without specifying Flex delegate
      final interpreterOptions = InterpreterOptions();

      _interpreter = await Interpreter.fromAsset(
        'assets/model_for_verify.tflite',
        options: interpreterOptions,
      );

      print("Model loaded successfully.");
      setState(() {});  // Update UI once the model loads
    } catch (e) {
      print("Error loading model: $e");
    }
  }


  @override
  void dispose() {
    _interpreter?.close(); // Close interpreter
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pose Verification')),
      body: Center(
        child: _interpreter == null
            ? CircularProgressIndicator() // Show loading while the model loads
            : Text('Model Loaded Successfully!'), // Show when loaded
      ),
    );
  }
}

 */

import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:io'; // Needed for File type

class PoseVerification extends StatefulWidget {
  final File? imageFile; // Define imageFile as an optional parameter

  PoseVerification({this.imageFile}); // Constructor with imageFile

  @override
  _PoseVerificationState createState() => _PoseVerificationState();
}

class _PoseVerificationState extends State<PoseVerification> {
  Interpreter? _interpreter;


  Future<void> loadModel() async {

    try {
      final interpreterOptions = InterpreterOptions();

      _interpreter = await Interpreter.fromAsset(
        'model_for_verify.tflite',
        options: interpreterOptions,
      );

      print("Model loaded successfully.");
      setState(() {}); // Update UI once the model loads
    } catch (e) {
      print("Error loading model: $e");
    }
  }



  @override
  void initState() {
    super.initState();
    loadModel(); // Load the model when the widget initializes
  }

  @override
  void dispose() {
    _interpreter?.close(); // Close interpreter when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pose Verification')),
      body: Center(
        child: _interpreter == null
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.imageFile != null
                ? Image.file(widget.imageFile!) // Display the image if available
                : Text('No Image Selected'),
            SizedBox(height: 20),
            Text('Model Loaded Successfully!'), // Show when loaded
          ],
        ),
      ),
    );
  }
}
