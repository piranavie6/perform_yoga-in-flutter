import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Function to validate password strength
String validatePassword(String password) {
  if (password.length < 6) {
    return 'Password must be at least 6 characters long';
  }

  final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
  final hasDigits = RegExp(r'\d').hasMatch(password);
  final hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  if (!hasUppercase) {
    return 'Password must include at least one uppercase letter';
  }

  if (!hasLowercase) {
    return 'Password must include at least one lowercase letter';
  }

  if (!hasDigits) {
    return 'Password must include at least one number';
  }

  if (!hasSpecialCharacters) {
    return 'Password must include at least one special character';
  }

  return 'Password is strong';
}

class RegisterPage extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _register(String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Validate password
    final passwordValidationMessage = validatePassword(password);
    if (passwordValidationMessage != 'Password is strong') {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(passwordValidationMessage)),
      );
      return;
    }

    if (password != _confirmPasswordController.text) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.5/yoga_app/register.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'password': password,
        }.map((key, value) => MapEntry(key, Uri.encodeComponent(value))),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          // Show success message
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text('Registration successful!'),
              backgroundColor: Colors.green,
            ),
          );
          // Wait for a moment before navigating to login page
          await Future.delayed(Duration(seconds: 2));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LogInPage()),
          );
        } else {
          // Show error message from server
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? 'Failed to register')),
          );
        }
      } else {
        // Show error message for non-200 status code
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Failed to register. Please try again later.')),
        );
      }
    } catch (e) {
      // Handle any exceptions that might occur during HTTP request
      print('Error during HTTP request: $e');
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to register. Please check your internet connection.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 51),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
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
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                            ),
                            child: SizedBox(
                              width: 375,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(33.5, 17.2, 14.7, 15.3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/layer_111.png',
                                ),
                              ),
                            ),
                            child: Container(
                              width: 378,
                              height: 226,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0.6, 0, 0, 0),
                          child: Opacity(
                            opacity: 0.3,
                            child: Text(
                              'Welcome Back!',
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0.7, 0, 0, 0),
                          child: Text(
                            'Register',
                            style: GoogleFonts.getFont(
                              'Lexend',
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                              color: Color(0xFF085364),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(26, 0, 22, 18),
                          padding: EdgeInsets.fromLTRB(11.5, 11.5, 11.5, 11.5),
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
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your password',
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
                              hintText: 'Enter your Confirm password',
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
                              String password = _passwordController.text;
                              String confirmPassword = _confirmPasswordController.text;

                              if (password == confirmPassword) {
                                _register(email, password, context);
                              } else {
                                _scaffoldMessengerKey.currentState?.showSnackBar(
                                  SnackBar(content: Text('Passwords do not match')),
                                );
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 213,
                              padding: EdgeInsets.fromLTRB(0, 6.5, 0.3, 6.5),
                              child: Text(
                                'Register',
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
                                  text: 'Already have an account ?  ',
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
                                          Navigator.push(
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
                ]
            ),
          ),
        ),
      ),
    );
  }
}
