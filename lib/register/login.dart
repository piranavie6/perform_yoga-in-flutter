import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'register_page.dart';
import 'resetpassword.dart';
import 'package:http/http.dart' as http; // For HTTP requests
import 'dart:convert'; // For JSON decoding
// ignore: duplicate_import

import 'package:fluttertoast/fluttertoast.dart';



class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // Controllers for managing input
  //final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
      final GlobalKey<ScaffoldMessengerState> _loginScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();


      final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



    Future<void> _login(String email, String password) async {
      final response = await http.post(
        Uri.parse('http://localhost/yoga_app/login.php'),//172.31.99.139
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        },
        body: {
          'email': email,
          'password': password,
        },
        encoding: Encoding.getByName('utf-8'),
      );

      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        Fluttertoast.showToast(
          msg: 'Login successful!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Login failed. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SingleChildScrollView(
          child:Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
            ),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: SingleChildScrollView(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  SizedBox(
                    width: 378,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(5, 50, 20, 5),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/layer_11.png',
                              ),
                            ),
                          ),
                          child: const SizedBox(
                            width: 378,
                            height: 226,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0.4, 3),
                          child: Opacity(
                            opacity: 0.3,
                            child: Text(
                              'Welcome Back!',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 12.7, 25),
                          child: Text(
                            'Log in',
                            style: GoogleFonts.getFont(
                              'Lexend',
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                              color: const Color(0xFF085364),
                            ),
                          ),
                        ),
                        // Email TextField with Controller
                        Container(
                          margin: const EdgeInsets.fromLTRB(26, 0, 22, 18),
                          padding: const EdgeInsets.all(11.5),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xE5C0C0C0)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your email',
                              hintStyle: GoogleFonts.getFont(
                                'Lexend',
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: const Color(0xFF333333),
                              ),
                            ),
                          ),
                        ),
                        // Password TextField with Controller
                        Container(
                          margin: const EdgeInsets.fromLTRB(23, 0, 25, 18.2),
                          padding: const EdgeInsets.fromLTRB(11, 11, 13, 11.8),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xE5C0C0C0)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your password',
                              hintStyle: GoogleFonts.getFont(
                                'Lexend',
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: const Color(0xFF333333),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to ResetPasswordPage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      const ResetPasswordPage()),
                                );
                              },
                              child: Text(
                                'Forgot password?',
                                style: GoogleFonts.getFont(
                                  'Lexend',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(0xFFD60E0E),
                                ),
                              ),
                            ),
                          ),
                        ),
// Login Button
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFF23B94D),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0D000000),
                                offset: Offset(0, 1),
                                blurRadius: 1,
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              _login(email, password);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 213,
                              padding: const EdgeInsets.fromLTRB(0, 6.5, 0.3, 6.5),
                              child: Text(
                                'Next',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19,
                                  height: 1.5,
                                  color: const Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                              text: TextSpan(
                                text: 'Don’t have an account ?  ',
                                style: GoogleFonts.getFont(
                                  'Lexend',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: const Color(0xFF000000),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Register',
                                    style: GoogleFonts.getFont(
                                      'Lexend',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.3,
                                      color: const Color(0xFF1886B5),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle registration action
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      );
    }
  }
