import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

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
        //Uri.parse('http://172.31.99.157/yoga_app/register.php'),
        //Uri.parse('http://172.31.99.157/yoga_app/login.php'),
        Uri.parse('${AppConfig.baseUrl}/register.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'password': password,
        }.map((key, value) => MapEntry(key, Uri.encodeComponent(value))),
      );

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
          // Wait before navigating
          await Future.delayed(Duration(seconds: 2));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LogInPage()),
          );
        } else {
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(content: Text(responseData['message'] ?? 'Failed to register')),
          );
        }
      } else {
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(content: Text('Failed to register. Please try again later.')),
        );
      }
    } catch (e) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('Failed to register. Check your internet connection.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              width: size.width,
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Logo Section
                  Container(
                    height: size.height * 0.25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/layer_111.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Welcome Text
                  Opacity(
                    opacity: 0.3,
                    child: Text(
                      'Welcome Back!',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.07,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Register Text
                  Text(
                    'Register',
                    style: GoogleFonts.getFont(
                      'Lexend',
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.07,
                      color: const Color(0xFF085364),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email Input
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your email',
                        hintStyle: GoogleFonts.getFont(
                          'Lexend',
                          fontWeight: FontWeight.w300,
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password Input
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
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
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Confirm Password Input
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm your password',
                        hintStyle: GoogleFonts.getFont(
                          'Lexend',
                          fontWeight: FontWeight.w300,
                          fontSize: size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Register Button
                  GestureDetector(
                    onTap: () {
                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();
                      _register(email, password, context);
                    },
                    child: Container(
                      width: size.width * 0.6,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF23B94D),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Register',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Already have an account
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.getFont(
                        'Lexend',
                        fontSize: size.width * 0.035,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: GoogleFonts.getFont(
                            'Lexend',
                            fontWeight: FontWeight.w400,
                            fontSize: size.width * 0.035,
                            color: const Color(0xFF1886B5),
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
