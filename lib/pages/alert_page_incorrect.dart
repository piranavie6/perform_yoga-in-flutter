// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'dart:ui';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_app/register/login.dart';
// import 'home_page.dart';
//
//
// class AlertPage1Incorrect extends StatelessWidget {
//
//   final File imageFile;  // Declare a final variable to receive the image
//
//   // Constructor to accept the imageFile parameter
//   const AlertPage1Incorrect({Key? key, required this.imageFile}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     body: Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFFFFFFF),
//       ),
//       child: Container(
//         padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin:EdgeInsets.fromLTRB(31.5, 30, 31.5, 11),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: Text(
//                   'Oops!\nWrong posture',
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.getFont(
//                     'Inknut Antiqua',
//                     fontWeight: FontWeight.w500,
//                     fontSize: 35,
//                     height: 1,
//                     color: Color(0xFFC72828),
//                   ),
//                 ),
//               ),
//             ),
//
//             Container(
//               margin: EdgeInsets.fromLTRB(5.3, 0, 0, 22),
//               child: Text(
//                 'You have performed the yoga pose wrong.\nIt may lead to various issues',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.getFont(
//                   'Itim',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 20,
//                   height: 1,
//                   color: Color(0xE5817E7E),
//                 ),
//               ),
//             ),
//
//             Container(
//               margin: const EdgeInsets.fromLTRB(21, 0, 21, 4),
//               width: 333,
//               height: 353,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 image: const DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage('assets/images/rectangle_18.jpeg'),
//                 ),
//               ),
//             ),
//
//             Container(
//               margin: EdgeInsets.fromLTRB(25.2, 0, 21.2, 26),
//               child: Text(
//                 'The red circles indicate the incorrect posture positions.',
//                 style: GoogleFonts.getFont(
//                   'Itim',
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   height: 1,
//                   color: Color(0xFFFF0000),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 // Navigate to the home page
//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => HomePage()), // Replace `HomePage()` with your actual home page widget
//                       (Route<dynamic> route) => false,
//                 );
//               },
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(7, 0, 0, 26),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: Color(0xFF09E360),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0x0D000000),
//                       offset: Offset(0, 1),
//                       blurRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   width: 284,
//                   alignment: Alignment.center, // Center the text inside the container
//
//                   padding: EdgeInsets.fromLTRB(0, 12.5, 0.9, 12.5),
//                   child: Text(
//                     'Try again',
//                     style: GoogleFonts.getFont(
//                       'Inter',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 24,
//                       height: 1.5,
//                       color: Color(0xFFFFFFFF),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 // Navigate to the home page
//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => HomePage()), // Replace `HomePage()` with your actual home page widget
//                       (Route<dynamic> route) => false,
//                 );
//               },
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(7, 0, 0, 26),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: Color(0xFF09E360),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0x0D000000),
//                       offset: Offset(0, 1),
//                       blurRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   width: 284,
//                   alignment: Alignment.center, // Center the text inside the container
//
//                   padding: EdgeInsets.fromLTRB(0, 12.5, 0.9, 12.5),
//                   child: Text(
//                     'View Profile',
//                     style: GoogleFonts.getFont(
//                       'Inter',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 24,
//                       height: 1.5,
//                       color: Color(0xFFFFFFFF),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 // Navigate to the home page
//                 Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => LogInPage()), // Replace `HomePage()` with your actual home page widget
//                       (Route<dynamic> route) => false,
//                 );
//               },
//               child: Container(
//                 margin: EdgeInsets.fromLTRB(7, 0, 0, 26),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   color: Color(0xFF09E360),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0x0D000000),
//                       offset: Offset(0, 1),
//                       blurRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   width: 284,
//                   alignment: Alignment.center, // Center the text inside the container
//
//                   padding: EdgeInsets.fromLTRB(0, 12.5, 0.9, 12.5),
//                   child: Text(
//                     'Log out',
//                     style: GoogleFonts.getFont(
//                       'Inter',
//                       fontWeight: FontWeight.w500,
//                       fontSize: 24,
//                       height: 1.5,
//                       color: Color(0xFFFFFFFF),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     )
//     );
//   }
// }






import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class AlertPage1Incorrect extends StatefulWidget {
  final File imageFile;

  const AlertPage1Incorrect({Key? key, required this.imageFile}) : super(key: key);

  @override
  _AlertPage1IncorrectState createState() => _AlertPage1IncorrectState();
}

class _AlertPage1IncorrectState extends State<AlertPage1Incorrect> {
  File? markedImage; // To store the marked image
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getMarkedImage();
  }

  Future<void> _getMarkedImage() async {
    final fetchedImage = await fetchMarkedImage(widget.imageFile);
    setState(() {
      markedImage = fetchedImage;
      isLoading = false;
    });
  }

  Future<File?> fetchMarkedImage(File imageFile) async {
    final uri = Uri.parse('http://172.31.99.137:5000/mark_pose_from_image'); // Your Flask server URL
    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final bytes = await response.stream.toBytes();
        final tempDir = await Directory.systemTemp.createTemp();
        final filePath = '${tempDir.path}/marked_image.jpg';
        final markedImageFile = File(filePath)..writeAsBytesSync(bytes);
        return markedImageFile;
      } else {
        print('Server returned status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching marked image: $e');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show a loader while fetching the image
          : Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(31.5, 30, 31.5, 11),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'Oops!\nWrong posture',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Inknut Antiqua',
                    fontWeight: FontWeight.w500,
                    fontSize: 35,
                    height: 1,
                    color: Color(0xFFC72828),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(5.3, 0, 0, 22),
              child: Text(
                'You have performed the yoga pose wrong.',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Itim',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  height: 1,
                  color: Color(0xE5817E7E),
                ),
              ),
            ),
            markedImage != null
                ? Container(
              margin: const EdgeInsets.fromLTRB(21, 0, 21, 4),
              width: 333,
              height: 353,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(markedImage!), // Display the marked image
                ),
              ),
            )
                : const Text('Failed to load marked image'),
            Container(
              margin: const EdgeInsets.fromLTRB(25.2, 0, 21.2, 26),
              child: Text(
                'The red circles indicate the incorrect posture positions.',
                style: GoogleFonts.getFont(
                  'Itim',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1,
                  color: Color(0xFFFF0000),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(7, 0, 0, 26),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF09E360),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      offset: Offset(0, 1),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Container(
                  width: 284,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(0, 12.5, 0.9, 12.5),
                  child: Text(
                    'Try again',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      height: 1.5,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


