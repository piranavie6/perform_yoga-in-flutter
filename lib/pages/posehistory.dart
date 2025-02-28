import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DatabaseHelper.dart';  // Ensure this file is imported correctly

class PoseHistoryPage extends StatefulWidget {
  @override
  _PoseHistoryPageState createState() => _PoseHistoryPageState();
}

class _PoseHistoryPageState extends State<PoseHistoryPage> {
  late Future<List<Map<String, dynamic>>> _poses;

  @override
  void initState() {
    super.initState();
    _poses = DatabaseHelper().fetchPoses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 17.2, 13.4, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/vectors/image_11_x2.svg',
                      width: 28.4,
                      height: 11.1,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/vectors/mobile_signal_6_x2.svg',
                          width: 17,
                          height: 10.7,
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset(
                          'assets/vectors/wifi_5_x2.svg',
                          width: 15.3,
                          height: 11,
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset(
                          'assets/vectors/battery_11_x2.svg',
                          width: 24.3,
                          height: 11.3,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 37.3),
                Center(
                  child: Text(
                    'Pose History',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      height: 1.4,
                      letterSpacing: -0.4,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                SizedBox(height: 34),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Posename',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.4,
                        letterSpacing: -0.2,
                        color: Color(0xFF000000),
                      ),
                    ),
                    Text(
                      'Correctness of Pose',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.4,
                        letterSpacing: -0.2,
                        color: Color(0xFF000000),
                      ),
                    ),
                    Text(
                      'Date',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        height: 1.4,
                        letterSpacing: -0.2,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                Divider(color: Color(0x80C0C0C0)),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: _poses,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No pose history available.'));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final pose = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  pose['posename'] ?? 'Unknown Pose',  // Safe access
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    height: 1.4,
                                    letterSpacing: -0.2,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                                Text(
                                  pose['Correctness_of_pose'] ?? 'Unknown Status', // Safe access
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    height: 1.4,
                                    letterSpacing: -0.2,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                                Text(
                                  pose['Date'] ?? 'Unknown Status', // Safe access
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    height: 1.4,
                                    letterSpacing: -0.2,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
