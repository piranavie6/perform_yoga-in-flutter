import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'camera_capture.dart';

class DescriptionPage2 extends StatefulWidget {
  const DescriptionPage2({super.key});

  @override
  _DescriptionPage1State createState() => _DescriptionPage1State();
}

class _DescriptionPage1State extends State<DescriptionPage2> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/warrior.mp4');
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
                  'Stand tall with your feet together and arms at your sides.\n\n'
                  'Distribute your weight evenly across both feet.\n\n'
                  'Step your feet apart:\n'
                  'Step or jump your feet wide apart, about 3-4 feet distance.\n\n'
                  'Turn your feet:\n'
                  'Turn your right foot out 90 degrees so it points to the front of the mat.\n'
                  'Angle your left foot slightly inwards, about 15 degrees.\n\n'
                  'Align your heels:\n'
                  'Ensure your right heel is aligned with the arch of your left foot.\n\n'
                  'Bend your right knee:\n'
                  'Bend your right knee over your right ankle so that your shin is perpendicular to the floor.\n'
                  'Your thigh should be parallel to the floor, ensuring your knee does not extend beyond your ankle.\n\n'
                  'Extend your arms:\n'
                  'Raise your arms to shoulder height, parallel to the floor.\n'
                  'Stretch them out to the sides, palms facing down.\n\n'
                  'Engage your core and align your torso:\n'
                  'Keep your torso straight and center, avoiding leaning forward.\n'
                  'Engage your abdominal muscles for stability.\n\n'
                  'Gaze over your right hand:\n'
                  'Turn your head to the right and gaze over your right fingertips.\n\n'
                  'Hold the pose:\n'
                  'Maintain the pose for 30 seconds to 1 minute, breathing deeply.\n\n'
                  'Release the pose:\n'
                  'To release, straighten your right leg and lower your arms.\n'
                  'Turn your feet back to parallel and step or jump your feet back together into Mountain Pose.\n\n'
                  'Repeat on the other side:\n'
                  'Turn your left foot out 90 degrees and angle your right foot in slightly.\n'
                  'Repeat the steps for the opposite side.',
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
            builder: (context) => const CameraScreen(), // Replace with your actual camera page widget
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
          /*children: [
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
          ],*/
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
