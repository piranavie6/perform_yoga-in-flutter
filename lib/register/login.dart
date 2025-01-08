import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'register_page.dart';
import 'resetpassword.dart';
import 'package:http/http.dart' as http; // For HTTP requests
import 'dart:convert'; // For JSON decoding
import 'package:fluttertoast/fluttertoast.dart';
import 'config.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // Controllers for managing input
  final GlobalKey<ScaffoldMessengerState> _loginScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(String email, String password) async {
    final response = await http.post(
      //Uri.parse('http://172.31.99.157/yoga_app/login.php'),
      Uri.parse('${AppConfig.baseUrl}/login.php'),
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
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Section
                  Container(
                    margin: const EdgeInsets.only(top: 0, bottom: 20),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/layer_11.png'),
                      ),
                    ),
                    width: size.width * 0.7, // Make it responsive
                    height: size.height * 0.2,
                  ),
                  // Welcome Text
                  Opacity(
                    opacity: 0.3,
                    child: Text(
                      'Welcome Back!',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.07, // Adjust font size
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                  // Log In Text
                  Text(
                    'Log in',
                    style: GoogleFonts.getFont(
                      'Lexend',
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.07, // Adjust font size
                      color: const Color(0xFF085364),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email Input
                  Container(
                    padding: const EdgeInsets.all(12),
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
                          fontSize: size.width * 0.04,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Password Input
                  Container(
                    padding: const EdgeInsets.all(12),
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
                          fontSize: size.width * 0.04,
                          color: const Color(0xFF333333),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot password?',
                        style: GoogleFonts.getFont(
                          'Lexend',
                          fontWeight: FontWeight.w400,
                          fontSize: size.width * 0.035,
                          color: const Color(0xFFD60E0E),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  InkWell(
                    onTap: () {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      _login(email, password);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.6, // Responsive width
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF23B94D),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Next',
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: size.width * 0.045,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Register Section
                  RichText(
                    text: TextSpan(
                      text: 'Don’t have an account?  ',
                      style: GoogleFonts.getFont(
                        'Lexend',
                        fontWeight: FontWeight.w400,
                        fontSize: size.width * 0.035,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Register',
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
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
