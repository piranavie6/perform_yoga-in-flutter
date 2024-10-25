import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/gestures.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<ScaffoldMessengerState> _resetPasswordScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _resetPassword(String email, String newPassword) async {
    if (email.isEmpty || newPassword.isEmpty) {
      _resetPasswordScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (newPassword != _confirmPasswordController.text) {
      _resetPasswordScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://172.31.99.136/yoga_app/reset_password.php'), // Update with your URL
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'email': email,
          'new_password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          _resetPasswordScaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text('Password reset successful!'),
              backgroundColor: Colors.green, // Fix the background color
            ),
          );
          // Wait for a moment before navigating to login page
          await Future.delayed(Duration(seconds: 2));

          // Navigate to LogInPage after success (same as in register.dart)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LogInPage()),
          );
        } else {
          _resetPasswordScaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? 'Failed to reset password')),
          );
        }
      } else {
        _resetPasswordScaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Failed to reset password. Please try again later.')),
        );
      }
    } catch (e) {
      print('Error during HTTP request: $e');
      _resetPasswordScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to reset password. Please check your internet connection.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _resetPasswordScaffoldMessengerKey,  // Update key name here
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          decoration: BoxDecoration(color: Color(0xFFFFFFFF)),
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
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/layer_111.png'),
                            ),
                          ),
                          child: Container(
                            width: 378,
                            height: 226,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.7, 0, 0, 0),
                        child: Text(
                          'Reset Password',
                          style: GoogleFonts.getFont(
                            'Lexend',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color(0xFF085364),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(23, 0, 25, 18.2),
                        padding: EdgeInsets.fromLTRB(11, 11, 13, 11.8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xE5C0C0C0)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: _emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your email',
                            hintStyle: GoogleFonts.getFont(
                              'Lexend',
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(23, 0, 25, 18.2),
                        padding: EdgeInsets.fromLTRB(11, 11, 13, 11.8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xE5C0C0C0)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: _newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your new password',
                            hintStyle: GoogleFonts.getFont(
                              'Lexend',
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(23, 0, 25, 18.2),
                        padding: EdgeInsets.fromLTRB(11, 11, 13, 11.8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xE5C0C0C0)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Confirm your new password',
                            hintStyle: GoogleFonts.getFont(
                              'Lexend',
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(4, 0, 0, 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF23B94D),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0D000000),
                              offset: Offset(0, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: GestureDetector(
                          onTap: () {
                            String email = _emailController.text;
                            String newPassword = _newPasswordController.text;
                            _resetPassword(email, newPassword);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 213,
                            padding: EdgeInsets.fromLTRB(0, 6.5, 0.3, 6.5),
                            child: Text(
                              'Reset Password',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                height: 1.5,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: RichText(
                              text: TextSpan(
                                text: 'Remembered your password?  ',
                                style: GoogleFonts.getFont(
                                  'Lexend',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFF000000),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Log in',
                                    style: GoogleFonts.getFont(
                                      'Lexend',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.3,
                                      color: Color(0xFF1886B5),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => LogInPage()),
                                        );
                                      },
                                  ),
                                ],
                              ),
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
    );
  }
}
