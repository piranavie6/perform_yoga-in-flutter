import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = fetchUserDetailsFromAPI(); // Fetch user data from the API
  }

  // Fetch user details from the PHP API
  Future<Map<String, dynamic>> fetchUserDetailsFromAPI() async {
    // Replace localhost with your computer's local IP address if using a physical device
    final response = await http.get(Uri.parse('http://192.168.1.5/yoga_app/get_users.php'));

    if (response.statusCode == 200) {
      List<dynamic> users = json.decode(response.body);
      if (users.isNotEmpty) {
        return users[0]; // Assuming you want the first user in the list
      } else {
        throw Exception("No users found.");
      }
    } else {
      throw Exception("Failed to load user data.");
    }
  }

  String getNameFromEmail(String email) {
    return email.split('@')[0]; // Extract the part before '@' in the email
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No user data available.'));
          } else {
            final user = snapshot.data!;
            final name = getNameFromEmail(user['email']);
            final email = user['email'];
            final password = user['password'];

            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/image_5_x2.svg',
                            width: 28.4,
                            height: 11.1,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/vectors/mobile_signal_11_x2.svg',
                                width: 17,
                                height: 10.7,
                              ),
                              SizedBox(width: 5),
                              SvgPicture.asset(
                                'assets/vectors/wifi_12_x2.svg',
                                width: 15.3,
                                height: 11,
                              ),
                              SizedBox(width: 5),
                              SvgPicture.asset(
                                'assets/vectors/battery_8_x2.svg',
                                width: 24.3,
                                height: 11.3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFE6E6E6),
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Text(
                        'Profile',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          letterSpacing: -0.3,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Edit profile image',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Color(0xFF0D99FF),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    _buildInfoRow(context, 'Name', name),
                    _buildInfoRow(context, 'Email', email),
                    _buildInfoRow(context, 'Password', '•' * password.length), // Display bullets for password
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF000000),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
