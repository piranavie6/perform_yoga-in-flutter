/*import 'dart:io' as io; // for mobile
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // for kIsWeb check
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // camera package
import 'package:path_provider/path_provider.dart'; // for saving image on mobile
import 'package:universal_html/html.dart' as html; // for saving image on web

class CameraScreen extends StatefulWidget {
  //final List<CameraDescription> cameras;
  //const CameraScreen({Key? key, required this.cameras}) : super(key: key);
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;//new line aded
  XFile? capturedImage;
  bool isImageCaptured = false; // Track if the image is captured

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }
/*
  Future<void> _initializeCamera() async {
    _controller = CameraController(
      widget.cameras[0], // Use the first camera (usually rear camera)
      ResolutionPreset.max,
    );

    await _controller.initialize();
    setState(() {});
  }
*/
  Future<void> _initializeCameras() async {
    try {
      // Get the available cameras
      final cameras = await availableCameras();
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.max,
      );
      _initializeControllerFuture = _controller.initialize();
      await _initializeControllerFuture; // Wait until the camera is initialized
      setState(() {}); // Update the UI after initialization
    } catch (e) {
      print('Error initializing camera: $e');
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
        isImageCaptured = true; // Set to true when the image is captured
      });

      if (kIsWeb) {
        await _saveImageWeb(image);
      } else {
        await _saveImageMobile(image);
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _saveImageMobile(XFile image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/captured_image.jpg';
      await image.saveTo(imagePath);
      print('Image saved to $imagePath');
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> _saveImageWeb(XFile image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final blob = html.Blob([imageBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'captured_image.jpg')
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error saving image on web: $e');
    }
  }

  void _retakeImage() async {
    setState(() {
      isImageCaptured = false; // Reset to show the camera view
      capturedImage = null; // Clear the captured image
    });
    await _initializeCameras(); // Reinitialize the camera
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized && !isImageCaptured) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('3-Second Timer Camera'),
        centerTitle: true,
      ),
      body: isImageCaptured // Check if the image is captured
          ? Column(
        children: [
          FutureBuilder<Uint8List>(
            future: capturedImage!.readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
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
          ElevatedButton(
            onPressed: _retakeImage, // Retake button
            child: const Text('Retake Image'),
          ),
        ],
      )
          : Column(
        children: [
          Expanded(
            child: CameraPreview(_controller), // Display camera preview
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _captureImageWithTimer, // Start 3-second timer and capture image
            child: const Text('Capture Image (3 sec timer)'),
          ),
        ],
      ),
    );
  }
}*/
//running cool
/*
import 'dart:io' as io; // for mobile
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // for kIsWeb check
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // camera package
import 'package:path_provider/path_provider.dart'; // for saving image on mobile
import 'package:universal_html/html.dart' as html; // for saving image on web

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile? capturedImage;
  bool isImageCaptured = false; // Track if the image is captured
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      // Get the available cameras
      final cameras = await availableCameras();
      _controller = CameraController(
        cameras[0],
        ResolutionPreset.max,
      );
      _initializeControllerFuture = _controller.initialize();

      // Wait until the camera is initialized
      await _initializeControllerFuture;

      // Update the UI after initialization
      setState(() {
        isLoading = false; // Set loading to false when done
      });
    } catch (e) {
      print('Error initializing camera: $e');
      setState(() {
        isLoading = false; // Set loading to false in case of error as well
      });
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
        isImageCaptured = true; // Set to true when the image is captured
      });

      if (kIsWeb) {
        await _saveImageWeb(image);
      } else {
        await _saveImageMobile(image);
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _saveImageMobile(XFile image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/captured_image.jpg';
      await image.saveTo(imagePath);
      print('Image saved to $imagePath');
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> _saveImageWeb(XFile image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final blob = html.Blob([imageBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'captured_image.jpg')
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error saving image on web: $e');
    }
  }

  void _retakeImage() async {
    setState(() {
      isImageCaptured = false; // Reset to show the camera view
      capturedImage = null; // Clear the captured image
    });
    await _initializeCameras(); // Reinitialize the camera
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
        title: const Text('3-Second Timer Camera'),
        centerTitle: true,
      ),
      body: isImageCaptured // Check if the image is captured
          ? Column(
        children: [
          FutureBuilder<Uint8List>(
            future: capturedImage!.readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
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
          ElevatedButton(
            onPressed: _retakeImage, // Retake button
            child: const Text('Retake Image'),
          ),
        ],
      )
          : Column(
        children: [
          Expanded(
            child: CameraPreview(_controller), // Display camera preview
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _captureImageWithTimer, // Start 3-second timer and capture image
            child: const Text('Capture Image (3 sec timer)'),
          ),
        ],
      ),
    );
  }
}*/
import 'dart:io' as io; // for mobile
import 'dart:typed_data';
import 'package:flutter/foundation.dart'; // for kIsWeb check
import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // camera package
import 'package:path_provider/path_provider.dart'; // for saving image on mobile
import 'package:universal_html/html.dart' as html; // for saving image on web

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile? capturedImage;
  bool isImageCaptured = false; // Track if the image is captured
  bool isLoading = true; // Track loading state
  late List<CameraDescription> cameras; // List of available cameras
  int selectedCameraIndex = 0; // Index to track which camera is selected

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      // Get the available cameras
      cameras = await availableCameras();
      _controller = CameraController(
        cameras[selectedCameraIndex],
        ResolutionPreset.max,
      );
      _initializeControllerFuture = _controller.initialize();

      // Wait until the camera is initialized
      await _initializeControllerFuture;

      // Update the UI after initialization
      setState(() {
        isLoading = false; // Set loading to false when done
      });
    } catch (e) {
      print('Error initializing camera: $e');
      setState(() {
        isLoading = false; // Set loading to false in case of error as well
      });
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
        isImageCaptured = true; // Set to true when the image is captured
      });

      if (kIsWeb) {
        await _saveImageWeb(image);
      } else {
        await _saveImageMobile(image);
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _saveImageMobile(XFile image) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/captured_image.jpg';
      await image.saveTo(imagePath);
      print('Image saved to $imagePath');
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> _saveImageWeb(XFile image) async {
    try {
      final imageBytes = await image.readAsBytes();
      final blob = html.Blob([imageBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'captured_image.jpg')
        ..click();
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error saving image on web: $e');
    }
  }

  void _retakeImage() async {
    setState(() {
      isImageCaptured = false; // Reset to show the camera view
      capturedImage = null; // Clear the captured image
    });
    await _initializeCameras(); // Reinitialize the camera
  }

  Future<void> _switchCamera() async {
    setState(() {
      isLoading = true; // Show loading indicator during camera switch
    });

    selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length; // Toggle camera index
    await _initializeCameras(); // Reinitialize with the new camera
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
        title: const Text('3-Second Timer Camera'),
        centerTitle: true,
      ),
      body: isImageCaptured // Check if the image is captured
          ? Column(
        children: [
          FutureBuilder<Uint8List>(
            future: capturedImage!.readAsBytes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
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
          ElevatedButton(
            onPressed: _retakeImage, // Retake button
            child: const Text('Retake Image'),
          ),
        ],
      )
          : Column(
        children: [
          Expanded(
            child: CameraPreview(_controller), // Display camera preview
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _captureImageWithTimer, // Start 3-second timer and capture image
            child: const Text('Capture Image (3 sec timer)'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _switchCamera, // Switch camera button
            child: const Text('Switch Camera'),
          ),
        ],
      ),
    );
  }
}





