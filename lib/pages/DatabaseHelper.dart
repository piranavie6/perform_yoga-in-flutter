import 'package:http/http.dart' as http;
import 'dart:convert';

import '../register/config.dart';

class DatabaseHelper {
  Future<List<Map<String, dynamic>>> fetchPoses() async {
    final response = await http.get(Uri.parse('${AppConfig.baseUrl}/get_poses.php'));

    if (response.statusCode == 200) {
      final List<dynamic> poses = jsonDecode(response.body);
      return poses.map((pose) => {
        'poseid': pose['poseid'],
        'posename': pose['posename'],
        'Correctness_of_pose': pose['Correctness_of_pose'],
        'Date': pose['Date'],
      }).toList();
    } else {
      throw Exception('Failed to load poses');
    }
  }
}
