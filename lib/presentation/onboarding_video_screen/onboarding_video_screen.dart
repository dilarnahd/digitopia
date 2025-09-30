import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../core/app_export.dart';
// import './widgets/exit_confirmation_dialog.dart';
// import './widgets/video_controls_overlay.dart';
// import './widgets/video_loading_overlay.dart';
// import './widgets/video_progress_dots.dart';

class OnboardingVideoScreen extends StatefulWidget {
  const OnboardingVideoScreen({super.key});

  @override
  State<OnboardingVideoScreen> createState() => _OnboardingVideoScreenState();
}

class _OnboardingVideoScreenState extends State<OnboardingVideoScreen>
    with TickerProviderStateMixin {
  // Old video state management - commented out
  // bool _isPlaying = false;
  // bool _showControls = true;
  // bool _isLoading = true;
  // bool _isInitialized = false;
  // int _currentVideoIndex = 0;
  // double _progress = 0.0;
  // Duration _currentPosition = Duration.zero;
  // Duration _totalDuration = const Duration(minutes: 2, seconds: 30);

  // Animation controllers - commented out
  // late AnimationController _controlsAnimationController;
  // late AnimationController _fadeAnimationController;

  // Old mock video data - commented out
  // final List<Map<String, dynamic>> _videoData = [...];

  // New simple video logic
  late VideoPlayerController _videoController;
  bool _videoFinished = false;

  @override
  void initState() {
    super.initState();

    // Commented out old init
    // _initializeAnimations();
    // _initializeVideo();
    // _startControlsTimer();

    _videoController =
        VideoPlayerController.asset('assets/video/onboarding.mp4')
          ..initialize().then((_) {
            setState(() {}); // video ready
            _videoController.play();
          });

    _videoController.addListener(() {
      if (_videoController.value.position >=
              _videoController.value.duration &&
          !_videoFinished) {
        setState(() {
          _videoFinished = true; // show Go to Home button
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();

    // Old animation disposals - commented out
    // _controlsAnimationController.dispose();
    // _fadeAnimationController.dispose();

    super.dispose();
  }

  // Old video methods - commented out
  // void _playVideo() {...}
  // void _pauseVideo() {...}
  // void _simulateVideoProgress() {...}
  // void _onVideoEnded() {...}
  // void _nextVideo() {...}
  // void _skipVideo() {...}
  // void _completeOnboarding() {...}
  // void _togglePlayPause() {...}
  // void _onSeek(double value) {...}
  // void _toggleControls() {...}
  // void _startControlsTimer() {...}
  // void _showErrorMessage(String message) {...}
  // void _showExitDialog() {...}

  @override
  Widget build(BuildContext context) {
    // Hide status bar for cinematic experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF26465D), // plain dark background
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_videoController.value.isInitialized)
                  SizedBox(
                    width: 80.w, // mini video
                    height: 40.h,
                    child: VideoPlayer(_videoController),
                  )
                else
                  const CircularProgressIndicator(color: Colors.white),

                SizedBox(height: 4.h),

                if (_videoFinished)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/home-dashboard');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF26465D),
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 2.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Go to Home',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                // Old complex UI - commented out
                // Stack(
                //   children: [
                //     // Video player area
                //     Positioned.fill(...),
                //     // Video controls overlay
                //     Positioned.fill(...),
                //     // Progress dots
                //     Positioned(...),
                //     // Subtitles
                //     Positioned(...),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
