

import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'alert_page_correct.dart';
import 'alert_page_incorrect.dart';
import 'not_our_pose.dart';
import 'error.dart';

class PoseVerificationPage extends StatefulWidget {
  final File imageFile; // Receive the image file from capture_camera.dart

  const PoseVerificationPage({Key? key, required this.imageFile}) : super(key: key);


  @override
  _PoseVerificationPageState createState() => _PoseVerificationPageState();
}

class _PoseVerificationPageState extends State<PoseVerificationPage> {
  final String apiUrl = 'http://192.168.8.113:5000/predict_pose_from_image'; // Your Flask server URL
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
        }
        else if(result['result']=='NOT our Pose') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
              builder: (context) => NotMonitoredPosePage(),
              ),
          );
        }

        else {
          // Handle unexpected responses

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NotMonitoredPosePage(),
            ),
          );
        }
      } else {Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ErrorPage(errorMessage: 'Server error: ${response.statusCode}'),
        ),
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
      appBar: AppBar(),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
