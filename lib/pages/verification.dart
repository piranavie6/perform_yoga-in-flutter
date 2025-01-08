// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'alert_page_correct.dart';
// import 'alert_page_incorrect.dart';
// //import 'camera_capture.dart'
//
// class PoseVerificationPage extends StatefulWidget {
//   final File imageFile;  // Receive the image file from capture_camera.dart
//
//   PoseVerificationPage({required this.imageFile});
//
//   @override
//   _PoseVerificationPageState createState() => _PoseVerificationPageState();
// }
//
// class _PoseVerificationPageState extends State<PoseVerificationPage> {
//
//   @override
//   void initState() {
//     super.initState();
//     _processImage(widget.imageFile);  // Process the received image on initialization
//   }
//
//   Future<void> _processImage(File imageFile) async {
//     final uri = Uri.parse("http://192.168.98.208:5000/process_image");
//
//     try {
//       final request = http.MultipartRequest('POST', uri)
//         ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));
//
//       final response = await request.send();
//
//       if (response.statusCode == 200) {
//         final responseData = await http.Response.fromStream(response);
//         final jsonResponse = jsonDecode(responseData.body);
//
//         String result = jsonResponse['result'];
//
//         if (result == "Correct Pose") {
//           _navigateToAlertCorrectPage();
//         } else {
//           _navigateToAlertIncorrectPage();
//         }
//       } else {
//         _showError("Failed to connect to the server.");
//       }
//     } catch (e) {
//       _showError("An error occurred: $e");
//     }
//   }
//
//   void _navigateToAlertCorrectPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AlertPage1Correct()),
//     );
//   }
//
//   void _navigateToAlertIncorrectPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => AlertPage1Incorrect()),
//     );
//   }
//
//   void _showError(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Processing Pose...")),
//       body: Center(child: CircularProgressIndicator()),  // Loading indicator during processing
//     );
//   }
// }








import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'alert_page_correct.dart';
import 'alert_page_incorrect.dart';



class PoseVerificationPage extends StatefulWidget {
  final File imageFile; // Receive the image file from capture_camera.dart

  const PoseVerificationPage({Key? key, required this.imageFile}) : super(key: key);


  @override
  _PoseVerificationPageState createState() => _PoseVerificationPageState();
}

class _PoseVerificationPageState extends State<PoseVerificationPage> {
  final String apiUrl = 'http://172.31.99.137:5000/predict_pose_from_image'; // Your Flask server URL
  final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance

  Future<void> playSound(String soundFile) async {
    try {
      await _audioPlayer.play(AssetSource(soundFile)); // Play the sound file
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Future<void> verifyPose() async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(
        await http.MultipartFile.fromPath('image', widget.imageFile.path),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final Map<String, dynamic> result = jsonDecode(responseData);

        if (result['result'] == 'Incorrect Pose') {
          await playSound('assets/sounds/incorrect.aac');
          // Navigate to the incorrect alert page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AlertPage1Incorrect(imageFile: widget.imageFile),
            ),
          );
        } else if (result['result'] == 'Correct Pose') {
          // Navigate to the correct alert page
          await playSound('assets/sounds/correct.mp3');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AlertPage1Correct(),
            ),
          );
        } else {
          // Handle unexpected responses
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Unexpected server response: ${result['result']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    verifyPose();
  }
  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the audio player when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pose Verification')),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
