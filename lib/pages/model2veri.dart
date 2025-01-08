import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExtractAnglesPage extends StatefulWidget {
  final File imageFile; // Receive the image file from camera.dart

  const ExtractAnglesPage({Key? key, required this.imageFile}) : super(key: key);

  @override
  _ExtractAnglesPageState createState() => _ExtractAnglesPageState();
}

class _ExtractAnglesPageState extends State<ExtractAnglesPage> {
  final String apiUrl = 'http://172.31.99.137:5000/extract_angles_from_image'; // Flask server URL
  Map<String, dynamic>? extractedAngles; // To store angles from the server
  String? errorMessage; // To handle errors

  Future<void> fetchAngles() async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(
        await http.MultipartFile.fromPath('image', widget.imageFile.path),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final Map<String, dynamic> result = jsonDecode(responseData);

        if (result.containsKey('error')) {
          setState(() {
            errorMessage = result['error'];
          });
        } else {
          setState(() {
            extractedAngles = result;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Server error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAngles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Extracted Angles')),
      body: Center(
        child: extractedAngles != null
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: extractedAngles!.entries.map((entry) {
              return ListTile(
                title: Text('${entry.key}:'),
                subtitle: Text(entry.value.toString()),
              );
            }).toList(),
          ),
        )
            : errorMessage != null
            ? Text(
          errorMessage!,
          style: TextStyle(color: Colors.red, fontSize: 16),
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
