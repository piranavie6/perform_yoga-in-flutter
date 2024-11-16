import 'package:http/http.dart' as http;
import 'dart:convert';

class DatabaseHelper {
  Future<List<Map<String, dynamic>>> fetchPoses() async {
    final response = await http.get(Uri.parse('http://192.168.1.5/yoga_app/get_poses.php'));

    if (response.statusCode == 200) {
      final List<dynamic> poses = jsonDecode(response.body);
      return poses.map((pose) => {
        'poseid': pose['poseid'],
        'posename': pose['posename'],
      }).toList();
    } else {
      throw Exception('Failed to load poses');
    }
  }
}
