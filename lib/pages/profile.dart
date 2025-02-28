import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/register/welcome_page.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {
  String? lastLoginEmail;
  String? displayName;

  @override
  void initState() {
    super.initState();
    loadLastLoginEmail();  // Load the last used Gmail email
  }

  // Load the last used Gmail email from SharedPreferences
  Future<void> loadLastLoginEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lastLoginEmail = prefs.getString('lastLoginEmail');  // Retrieve the email
    if (lastLoginEmail != null) {
      displayName = lastLoginEmail!.split('@')[0];  // Extract name before '@'
    }
    print('Last login email: $lastLoginEmail');  // Debugging line to see the value
    setState(() {});  // Trigger a rebuild to update the profile page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lastLoginEmail == null
          ? Center(child: CircularProgressIndicator())  // Show loading indicator until email is loaded
          : SingleChildScrollView(
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

              SizedBox(height: 40),
              _buildInfoRow(
                  context,
                  'Name',
                  displayName ?? 'No name available' // Show name part before "@"
              ),
              _buildInfoRow(
                  context,
                  'Email',
                  lastLoginEmail ?? 'No email available'  // Show full email
              ),
            ],
          ),
        ),

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
