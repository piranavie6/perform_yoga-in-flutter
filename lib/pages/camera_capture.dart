import 'dart:io';
import 'package:flutter/foundation.dart'; // for kIsWeb check
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // camera package
import 'model2veri.dart'; // for saving image on mobile
import 'package:permission_handler/permission_handler.dart';
import 'classification.dart';
import 'verification.dart';
import 'alert_page_incorrect.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile? capturedImage;
  bool isImageCaptured = false; // Track if the image is captured
  bool isLoading = true; // Track loading state
  List<CameraDescription> cameras = []; // Initialize as empty
  int selectedCameraIndex = 0; // Index to track which camera is selected
  String classificationResult = ""; // To store the model's classification result


  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }


  Future<void> _initializeCameras() async {
    try {
      final statuses = await [Permission.camera, Permission.microphone].request();
      if (statuses[Permission.camera]?.isGranted == true &&
          statuses[Permission.microphone]?.isGranted == true) {
        cameras = await availableCameras();

        if (cameras.isNotEmpty) {
          _controller = CameraController(
            cameras[selectedCameraIndex],
            ResolutionPreset.max,
          );

          _initializeControllerFuture = _controller.initialize();
          await _initializeControllerFuture;

          setState(() {
            isLoading = false;
          });
        } else {
          print("No cameras found.");
          setState(() => isLoading = false);
        }
      } else {
        print("Camera or microphone permission denied.");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Error initializing camera: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _captureImageWithTimer() async {
    // Start a 3-second countdown before capturing the image
    await Future.delayed(const Duration(seconds: 3));

    try {
      // Capture the image
      final image = await _controller.takePicture();
      setState(() {
        capturedImage = image;
        final imagePath = image.path; // This gives you the path to the captured image
        isImageCaptured = true; // Set to true when the image is captured


        Navigator.push(
          context,
          MaterialPageRoute(
             //builder: (context) => DetectionPage(imageFile: File(imagePath)), // Pass the image fil to clasify image
               // builder: (context) => ExtractAnglesPage(imageFile: File(imagePath)), // Pass the image file to extract angle
                  builder: (context) => PoseVerificationPage(imageFile: File(imagePath)),  // Pass the image file here
            // builder: (context) => MyWidget(),
              // builder: (context) => AlertPage1Incorrect(imagePath: imagePath),  // Pass the image file redmark here

          ),
        );
      });


/*
      if (kIsWeb) {
        await _saveImageWeb(image);
      } else {
        await _saveImageMobile(image);
      }
      _showResults(classificationResult); // Display classification result
*/
    } catch (e) {
      print('Error capturing image: $e');
    }
  }



  Future<void> _switchCamera() async {
    setState(() {
      isLoading = true; // Show loading indicator during camera switch
    });

    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length; // Toggle camera index
    await _initializeCameras(); // Reinitialize with the new camera
  }

  void _showResults(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator while waiting for camera permissions
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Check if the camera is initialized and not captured
    if (!_controller.value.isInitialized && !isImageCaptured) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pose Capture'),
        centerTitle: true,
      ),
      body:
      isImageCaptured
          ? Column(
        children: [
          FutureBuilder<Uint8List>(
            future: capturedImage!.readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return Image.memory(
                  snapshot.data!,
                  fit: BoxFit.contain,
                ); // Display captured image
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(height: 10),
          /* ElevatedButton(
            onPressed: _retakeImage, // Retake button
            style: ElevatedButton.styleFrom(
              backgroundColor:const Color(0xFF2196F3), // Color for Retake Image
            ),
            child: const Text('Retake Image'),
          ),*/
        ],
      )
          : Column(
        // children: [
        //   Expanded(
        //     child: _controller.value.isInitialized
        //         ? CameraPreview(_controller) // Display camera preview
        //         : const Center(child: CircularProgressIndicator()),
        //   ),
        //   const SizedBox(height: 10),
        //   ElevatedButton(
        //     onPressed: _captureImageWithTimer, // Start 3-second timer and capture image
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color(0xFF4CAF50), // Color for Capture Image
        //     ),
        //     child: const Text('Capture pose (3 sec timer)'),
        //   ),
        //   const SizedBox(height: 10),
        //   ElevatedButton(
        //     onPressed: _switchCamera, // Switch camera button
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color(0xFF03A9F4), // Color for Capture Image
        //     ),
        //     child: const Text('Switch Camera'),
        //   ),
        // ],
        children: [
          Expanded(
            child: _controller.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: CameraPreview(_controller), // Display camera preview
            )
                : const Center(child: CircularProgressIndicator()),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _captureImageWithTimer, // Start 3-second timer and capture image
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50), // Color for Capture Image
            ),
            child: const Text('Capture pose (3 sec timer)'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _switchCamera, // Switch camera button
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF03A9F4), // Color for Switch Camera
            ),
            child: const Text('Switch Camera'),
          ),
        ],

      ),

    );
  }
}
