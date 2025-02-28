import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'register_page.dart'; // Import the RegisterPage class

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,

          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image container
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/international_yoga_day_011.png'),
                      ),
                    ),
                    height: size.height * 0.35, // Adjusted height based on screen size
                    width: size.width * 0.8, // Adjusted width
                  ),
                  const SizedBox(height: 20),
                  // Welcome Text
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Welcome to PoseMaster!',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.07, // Responsive font size
                        color: const Color(0xFFD00303),
                      ),
                    ),
                  ),
                  // Tagline Text
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'The real time yoga pose monitoring system',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.04, // Responsive font size
                        color: const Color(0xFF8A8484),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  Container(
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xFF0EAC90),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x660EAC90),
                          offset: Offset(0, 7),
                          blurRadius: 9.4,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: const Color(0xFF0EAC90),
                        elevation: 5,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'LOG IN',
                          style: GoogleFonts.getFont(
                            'Jost',
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.05, // Responsive font size
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Register Button
                  Container(
                    width: size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xFF097B60),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x660EAC90),
                          offset: Offset(0, 7),
                          blurRadius: 9.4,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        backgroundColor: const Color(0xFF097B60),
                        elevation: 5,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'REGISTER',
                          style: GoogleFonts.getFont(
                            'Jost',
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.05, // Responsive font size
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
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
