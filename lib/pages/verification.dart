import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerificationPage extends StatefulWidget {
  final File imageFile;

  VerificationPage({required this.imageFile});

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  Map<String, dynamic>? poseAngles;
  bool isLoading = true;

  Future<void> sendImageToServer() async {
    final uri = Uri.parse('http://192.168.1.32:5000/calculate_pose_angles'); // Update with the server's correct IP and port

    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', widget.imageFile.path));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        setState(() {
          poseAngles = jsonDecode(responseData); // Parse the JSON response
          isLoading = false; // Stop loading
        });
      } else {
        print('Failed to receive angles. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false; // Stop loading if there's an error
        });
      }
    } catch (e) {
      print('Error sending image: $e');
      setState(() {
        isLoading = false; // Stop loading if there's an error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    sendImageToServer(); // Send image to server when page is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pose Verification')),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : poseAngles != null
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Pose Angles:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          Text("Left Elbow: ${poseAngles?['left_elbow_angle']}°"),
          Text("Left Hip: ${poseAngles?['left_hip_angle']}°"),
          Text("Left Knee: ${poseAngles?['left_knee_angle']}°"),
          Text("Left Shoulder: ${poseAngles?['left_shoulder_angle']}°"),

          Text("Right Elbow: ${poseAngles?['right_elbow_angle']}°"),
          Text("Right Hip: ${poseAngles?['right_hip_angle']}°"),
          Text("Right Knee: ${poseAngles?['right_knee_angle']}°"),
          Text("Right Shoulder: ${poseAngles?['right_shoulder_angle']}°"),

          // Display additional angles here
        ],
      )
          : Center(child: Text("Failed to retrieve pose angles.")),
    );
  }
}
