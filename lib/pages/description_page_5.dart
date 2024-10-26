import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'camera_capture.dart';

class DescriptionPage5 extends StatefulWidget {
  const DescriptionPage5({super.key});

  @override
  _DescriptionPage1State createState() => _DescriptionPage1State();
}

class _DescriptionPage1State extends State<DescriptionPage5> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/tree.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _initializeVideoPlayerFuture.then((_) {
      // Video is initialized, you can set looping and start playback here if needed
      _controller.setLooping(true);
      _controller.play(); // Optional: Start playback immediately
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Stack(
        children: [
          _buildTopImage(),
          _buildMainContent(),
          _buildCenterImage(),
        ],
      ),
    );
  }

  Positioned _buildMainContent() {
    return Positioned(
      left: 0,
      right: 0,
      top: 290,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF42220D),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 160, 21, 22),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _buildBottomBox(),
                _buildDescriptionText(),
                _buildPrevButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildBottomBox() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 50,
      top: 0,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF42220D),
        ),
        child: const SizedBox(
          width: 375,
          height: 100,
        ),
      ),
    );
  }

  Column _buildDescriptionText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 27),
          width: 344,
          height: 242,
          child: SingleChildScrollView(
            child: Text(
              'Start in Mountain Pose (Tadasana):\n'
                  'Stand tall with your feet together and arms at your sides.\n'
                  'Distribute your weight evenly across both feet.\n\n'
                  'Shift your weight:\n'
                  'Shift your weight onto your left foot, grounding firmly into the floor.\n\n'
                  'Position your right foot:\n'
                  'Bend your right knee and bring the sole of your right foot to your left inner thigh, calf, or ankle (avoid placing it directly on the knee).\n'
                  'Use your hand to help position your foot if needed.\n\n'
                  'Find your balance:\n'
                  'Press your right foot into your left leg and your left leg back into your right foot to create stability.\n'
                  'Engage your core to help maintain balance.\n\n'
                  'Position your hips:\n'
                  'Ensure your hips are level and facing forward.\n'
                  'Keep your pelvis in a neutral position.\n\n'
                  'Engage your standing leg:\n'
                  'Firm your left thigh and avoid locking your knee.\n'
                  'Keep your standing leg strong and active.\n\n'
                  'Bring your hands to prayer position:\n'
                  'Place your palms together at your chest (Anjali Mudra).\n'
                  'Alternatively, you can raise your arms overhead, keeping them either parallel, with palms facing each other, or with palms touching.\n\n'
                  'Focus your gaze:\n'
                  'Find a fixed point in front of you to focus your gaze (drishti) to help with balance.\n\n'
                  'Hold the pose:\n'
                  'Maintain the pose for 30 seconds to 1 minute, breathing deeply and evenly.\n\n'
                  'Release the pose:\n'
                  'To release, lower your right foot back to the floor and return to Mountain Pose.\n'
                  'Repeat the pose on the opposite side, shifting your weight onto your right foot and positioning your left foot on your right inner thigh, calf, or ankle.',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 15,
                height: 1.5,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
        _buildNextButton(),
      ],
    );
  }



  GestureDetector _buildNextButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CameraScreen(), // Replace with your actual camera page widget
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFEEEEEE),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0.9),
          child: Text(
            'Next',
            style: GoogleFonts.getFont(
              'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 25,
              height: 1.5,
              color: const Color(0xFF000000),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildPrevButton() {
    return Positioned(
      left: 0,
      bottom: -1,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // Navigate back to the previous page
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF4C0565),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(0, 1),
                blurRadius: 1,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0.5),
            child: Text(
              'Prev',
              style: GoogleFonts.getFont(
                'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 25,
                height: 1.5,
                color: const Color(0xFFFFFFFF),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Positioned _buildTopImage() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/untitled_11.jpeg'),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 0, 22, 0),
          child: Column(
            children: [
              _buildStatusBar(),
              const SizedBox(height: 50),
              Text(
                'Description',
                style: GoogleFonts.getFont(
                  'Inknut Antiqua',
                  fontWeight: FontWeight.w500,
                  fontSize: 29,
                  height: 1.5,
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildStatusBar() {
    return Container(
      width: double.infinity,
      height: 30,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/vectors/image_9_x2.svg',
              width: 28.4,
              height: 11.1,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/vectors/mobile_signal_10_x2.svg',
                  width: 17,
                  height: 10.7,
                ),
                const SizedBox(width: 5),
                SvgPicture.asset(
                  'assets/vectors/wifi_10_x2.svg',
                  width: 15.3,
                  height: 11,
                ),
                const SizedBox(width: 5),
                SvgPicture.asset(
                  'assets/vectors/battery_5_x2.svg',
                  width: 24.3,
                  height: 11.3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildCenterImage() {
    return Positioned(
      left: 0,
      right: 0,
      top: 160,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFC4C4C4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          width: 326,
          height: 268,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return VideoPlayer(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
