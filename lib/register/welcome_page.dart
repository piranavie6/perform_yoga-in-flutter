import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'register_page.dart'; // Import the RegisterPage class

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Added MaterialApp widget
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 43, 0, 46),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/international_yoga_day_011.png',
                    ),
                  ),
                ),
                child: const SizedBox(
                  width: 378,
                  height: 275,
                  // Removed image_4 asset
                ),
              ),
            ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(18, 0, 19.7, 10),//0.6, 0, 0, 11
                    child: Text(
                      'Welcome to PoseMaster!',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: const Color(0xFFD00303),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(31, 0, 31.8, 47),
                    child: Text(
                      'The real time yoga pose monitoring system',
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: const Color(0xFF8A8484),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 26),
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
                            builder: (context) => const LogInPage(), // Navigate to LogInPage
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
                        width: 143,
                        padding: const EdgeInsets.fromLTRB(0, 11, 0, 11),
                        child: Text(
                          'LOG IN',
                          style: GoogleFonts.getFont(
                            'Jost',
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                            builder: (context) => RegisterPage(), // Navigate to RegisterPage
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
                        width: 143,
                        padding: const EdgeInsets.fromLTRB(0, 11, 0, 11),
                        child: Text(
                          'REGISTER',
                          style: GoogleFonts.getFont(
                            'Jost',
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
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
