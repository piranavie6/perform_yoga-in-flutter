import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'package:flutter_app/register/login.dart';
import 'alert_page_incorrect.dart';

class AlertPage1Correct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 57),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              margin: EdgeInsets.fromLTRB(5, 20, 20, 43),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/f_489394725_oox_6_jg_48_u_2_k_0_fsk_4_rl_pczqk_u_7_qvu_2_bsu_1.jpeg',
                    ),
                  ),
                ),
                child: Container(
                  width: 371,
                  height: 265,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(18, 0, 0, 20),
              child: Text(
                'Well Done!',
                style: GoogleFonts.getFont(
                  'Inknut Antiqua',
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                  height: 1.5,
                  color: Color(0xFF8F00E7),
                ),

              ),
            ),
            Container(
              margin:EdgeInsets.fromLTRB(33.2, 20, 26.2, 46),
              child: Text(
                'You achieved the yoga pose perfectly.',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Itim',
                  fontWeight: FontWeight.w400,
                  fontSize: 26,
                  height: 1,
                  color: Color(0xE5817E7E),
                ),
                overflow: TextOverflow.visible, // Handle any overflow to avoid yellow underline

              ),
            ),

      GestureDetector(
        onTap: () {
          // Navigate to the home page
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomePage()), // Replace `HomePage()` with your actual home page widget
                (Route<dynamic> route) => false,
          );
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(7, 0, 0, 26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color(0xFF09E360),
            boxShadow: [
              BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(0, 1),
                blurRadius: 1,
              ),
            ],
          ),
          child: Container(
            width: 284,
            alignment: Alignment.center, // Center the text inside the container

            padding: EdgeInsets.fromLTRB(0, 12.5, 0.9, 12.5),
            child: Text(
              'Next Yoga',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 24,
                height: 1.5,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),

        GestureDetector(
          onTap: () {
            // Clear user session data here
            // Navigate to the login page and remove all previous routes from the stack

            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LogInPage()), // Replace `LoginPage()` with your login page widget
                  (Route<dynamic> route) => false,
            );
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 20),
            decoration:   BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xFFD23434),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
            child: Container(
              width: 281,
              color: Color(0x0504AA),
              alignment: Alignment.center, // Center the text inside the container

              padding: EdgeInsets.fromLTRB(0, 14, 0.5, 14),
              child: Text(
                'View Profile',
                style: GoogleFonts.getFont(
                  'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  height: 1.5,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),

            GestureDetector(
              onTap: () {
                // Clear user session data here
                // Navigate to the login page and remove all previous routes from the stack

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LogInPage()), // Replace `LoginPage()` with your login page widget
                      (Route<dynamic> route) => false,
                );
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 20),
                decoration:   BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xFFD23434),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0D000000),
                      offset: Offset(0, 1),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Container(
                  width: 281,
                  color: Color(0x0504AA),
                  alignment: Alignment.center, // Center the text inside the container

                  padding: EdgeInsets.fromLTRB(0, 14, 0.5, 14),
                  child: Text(
                    'Log out',
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      height: 1.5,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    )
    );
  }
}