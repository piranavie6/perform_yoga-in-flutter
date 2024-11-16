import 'package:flutter/material.dart';
import 'package:flutter_app/pages/profile.dart';
import 'package:flutter_app/pages/posehistory.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_1.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_2.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_3.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_4.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_5.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  // Function to insert pose data into the database
  Future<void> insertPoseData(String poseId, String poseName, String poseImage) async {
    final String url = 'http://192.168.1.5/yoga_app/insert_pose.php'; // Your PHP API URL

    try {
      // Making a POST request
      final response = await http.post(
        Uri.parse(url),
        body: {
          'poseid': poseId,
          'posename': poseName,
        },
      );

      // Check the response from the server
      if (response.statusCode == 200) {
        print("Pose data inserted successfully: ${response.body}");
      } else {
        print("Failed to insert pose data.");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Makes the AppBar transparent
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.home),
                          title: const Text('Profile'),
                          onTap: () {
                            Navigator.pop(context); // Close the BottomSheet
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings),
                          title: const Text('PoseHistory'),
                          onTap: () {
                            Navigator.pop(context); // Close the BottomSheet
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PoseHistoryPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )

        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // The rest of your code remains unchanged
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/home_1.jpeg',
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 7, 14, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(26),
                                bottomRight: Radius.circular(26),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  offset: Offset(0, 1),
                                  blurRadius: 1,
                                ),
                              ],
                            ),
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(13, 0, 13, 0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.getFont(
                              'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                              color: const Color(0xFF000000),
                            ),
                            children: [
                              TextSpan(
                                text: 'Welcome to',
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  height: 1.3,
                                  color: const Color(0xFFEEB9FF),
                                ),
                              ),
                              TextSpan(
                                text: 'PoseMaster!',
                                style: GoogleFonts.getFont(
                                  'Roboto Condensed',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 34,
                                  height: 1.3,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              decoration: const BoxDecoration(
                color: Color(0xFFE5CCFF),
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(13, 6, 12, 5),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: const Color(0xFF000000),
                    ),
                    children: [
                      TextSpan(
                        text: 'Choose a yoga stance and perform it.',
                        style: GoogleFonts.getFont(
                          'Roboto Condensed',
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          height: 1.3,
                        ),
                      ),
                      TextSpan(
                        text: 'To increase flexibility, strength & balance',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          height: 1.3,
                          color: const Color(0xFF8F779A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(13, 0, 21, 0),
                children: [
                  GestureDetector(
                    onTap: () {
                      insertPoseData('1', 'Goddess', 'component_5.png');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewquidanceAndOpenCamersSelectionPage1()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/component_1.png'),
                        ),
                      ),
                      child: const SizedBox(
                        width: 341,
                        height: 159,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      insertPoseData('2', 'Worriors', 'component_5.png');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewquidanceAndOpenCamersSelectionPage2()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/component_2.png'),
                        ),
                      ),
                      child: const SizedBox(
                        width: 341,
                        height: 159,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      insertPoseData('3', 'Downdog', 'component_5.png');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewquidanceAndOpenCamersSelectionPage3()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/component_3.png'),
                        ),
                      ),
                      child: const SizedBox(
                        width: 341,
                        height: 160,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      insertPoseData('4', 'Plank', 'component_5.png');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewquidanceAndOpenCamersSelectionPage4()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/component_4.png'),
                        ),
                      ),
                      child: const SizedBox(
                        width: 341,
                        height: 159,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      insertPoseData('5', 'Tree', 'component_5.png');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewquidanceAndOpenCamersSelectionPage5()),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/component_5.png'),
                        ),
                      ),
                      child: const SizedBox(
                        width: 341,
                        height: 159,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}