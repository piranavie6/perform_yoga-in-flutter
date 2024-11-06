import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Function to validate email format using regex
bool isValidEmail(String email) {
  // Regular expression to validate email with @gmail.com or @yahoo.com
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@(gmail\.com|yahoo\.com)$');
  return emailRegex.hasMatch(email);
}

// **************************Function to validate password strength
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
  //final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldMessengerState> _registerScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  RegisterPage({super.key});

  Future<void> _register(String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      _registerScaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Check if the email is valid
    if (!isValidEmail(email)) {
      _registerScaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Invalid email address. Please use a valid email (e.g., example@gmail.com or example@yahoo.com).')),
      );
      return;
    }

    // Validate password
    final passwordValidationMessage = validatePassword(password);
    if (passwordValidationMessage != 'Password is strong') {
      _registerScaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text(passwordValidationMessage)),
      );
      return;
    }

    if (password != _confirmPasswordController.text) {
      _registerScaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }


    try {
      final response = await http.post(
        Uri.parse('http://172.31.99.136/yoga_app/register_page.php'),//http://192.168.217.237/
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          // Show success message
          _registerScaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text('Registration successful!'),
              backgroundColor: Colors.green,
            ),
          );
          // Wait for a moment before navigating to login page
          await Future.delayed(const Duration(seconds: 2));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LogInPage()),
          );
        } else {
          // Show error message from server
          _registerScaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? 'Failed to register')),
          );
        }
      } else {
        // Show error message for non-200 status code
        _registerScaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(content: Text('Failed to register. Please try again later.')),
        );
      }
    } catch (e) {
      // Handle any exceptions that might occur during HTTP request
      print('Error during HTTP request: $e');
      _registerScaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Failed to register. Please check your internet connection.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _registerScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(0, 30 ,0, 0),
          decoration: const BoxDecoration(
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
                        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/layer_111.png',
                              ),
                            ),
                          ),
                          child: const SizedBox(
                            width: 378,
                            height: 226,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0.6, 20, 0, 0),
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
                        margin: const EdgeInsets.fromLTRB(10.7, 0, 0, 0),
                        child: Text(
                          'Register',
                          style: GoogleFonts.getFont(
                            'Lexend',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: const Color(0xFF085364),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(26, 0, 22, 18),
                        padding: const EdgeInsets.fromLTRB(11.5, 11.5, 11.5, 11.5),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xE5C0C0C0)),
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
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ),
                      ),
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
                        margin: const EdgeInsets.fromLTRB(23, 0, 25, 18.2),
                        padding: const EdgeInsets.fromLTRB(11, 11, 13, 11.8),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xE5C0C0C0)),
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
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(4, 0, 0, 14),
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
                        child: GestureDetector(
                          onTap: () {
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword = _confirmPasswordController.text;

                            if (password == confirmPassword) {
                              _register(email, password, context);
                            } else {
                              _registerScaffoldMessengerKey.currentState?.showSnackBar(
                                const SnackBar(content: Text('Passwords do not match')),
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 213,
                            padding: const EdgeInsets.fromLTRB(0, 6.5, 0.3, 6.5),
                            child: Text(
                              'Register',
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
                        margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
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
                                  color: const Color(0xFF000000),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Log in',
                                    style: GoogleFonts.getFont(
                                      'Lexend',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      height: 1.3,
                                      color: const Color(0xFF1886B5),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const LogInPage()),
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