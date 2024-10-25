import 'package:flutter/material.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_1.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_2.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_3.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_4.dart';
import 'package:flutter_app/pages/viewquidance_and_open_camers_selection_page_5.dart';
import 'register/login.dart';
import 'register/register_page.dart';
import 'register/resetpassword.dart';
import 'register/welcome_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'pages/camera_capture.dart';
import 'pages/description_page_1.dart';
import 'pages/description_page_2.dart';
import 'pages/description_page_3.dart';
import 'pages/description_page_4.dart';
import 'pages/description_page_5.dart';
import 'package:camera/camera.dart'; // Add camera package import

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome', // Change this to the route you want to start with

      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LogInPage(),
        '/register': (context) => RegisterPage(),
        '/resetpassword': (context) => ResetPasswordPage(),
        '/home': (context) => HomePage(),
        '/description1': (context) => DescriptionPage1(),
        '/description2': (context) => DescriptionPage2(),
        '/description3': (context) => DescriptionPage3(),
        '/description4': (context) => DescriptionPage4(),
        '/description5': (context) => DescriptionPage5(),
        '/camera': (context) => CameraScreen(), // Route to the camera screen
        '/guidline1': (context) => ViewquidanceAndOpenCamersSelectionPage1(),
        '/guidline2': (context) => ViewquidanceAndOpenCamersSelectionPage2(),
        '/guidline3': (context) => ViewquidanceAndOpenCamersSelectionPage3(),
        '/guidline4': (context) => ViewquidanceAndOpenCamersSelectionPage4(),
        '/guidline5': (context) => ViewquidanceAndOpenCamersSelectionPage5(),

        // Fixed the route path
      },
    );
  }
}
