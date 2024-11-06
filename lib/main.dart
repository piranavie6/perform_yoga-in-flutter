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
import 'pages/alert_page_correct.dart';
import 'pages/alert_page_incorrect.dart';
import 'pages/classification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  runApp(const MyApp()); // Run your main app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home', // Change this to the route you want to start with

      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LogInPage(),
        '/register': (context) => RegisterPage(),
        '/resetpassword': (context) => const ResetPasswordPage(),
        '/home': (context) => const HomePage(),
        '/description1': (context) => const DescriptionPage1(),
        '/description2': (context) => const DescriptionPage2(),
        '/description3': (context) => const DescriptionPage3(),
        '/description4': (context) => const DescriptionPage4(),
        '/description5': (context) => const DescriptionPage5(),
        '/camera': (context) => const CameraScreen(), // Route to the camera screen
        '/guidline1': (context) => const ViewquidanceAndOpenCamersSelectionPage1(),
        '/guidline2': (context) => const ViewquidanceAndOpenCamersSelectionPage2(),
        '/guidline3': (context) => const ViewquidanceAndOpenCamersSelectionPage3(),
        '/guidline4': (context) => const ViewquidanceAndOpenCamersSelectionPage4(),
        '/guidline5': (context) => const ViewquidanceAndOpenCamersSelectionPage5(),
        '/correct alert': (context) => AlertPage1Correct(),
        '/incorrect alert': (context) => AlertPage1Incorrect(),
       // '/classification' :(context) => DetectionPage(),



        // Fixed the route path
      },
    );
  }
}
