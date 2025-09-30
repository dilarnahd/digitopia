import 'package:egyptquest/presentation/today_s_discovery_screen/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import 'game.dart'; // Import the mini-game screen

class TodaySDiscoveryScreen extends StatefulWidget {
  const TodaySDiscoveryScreen({super.key});

  @override
  State<TodaySDiscoveryScreen> createState() => _TodaySDiscoveryScreenState();
}

class _TodaySDiscoveryScreenState extends State<TodaySDiscoveryScreen>
    with TickerProviderStateMixin {
  // Discovery data updated for glyphs/hieroglyphics
  final Map<String, dynamic> _discoveryData = {
    "id": 1,
    "title": "اكتشف الهيروغليفية!",
    "subtitle": "رحلة قصيرة داخل رموز المصريين القدماء",
    "content":
        "الهيروغليفية هي الكتابة التي استخدمها المصريون القدماء للتعبير عن أفكارهم وحياتهم اليومية. كل رمز أو جليفة لها معنى خاص، وبعضها يمثل أصواتًا محددة. استكشف معنا بعض هذه الرموز القديمة وتعرف على أسرارها.",
    "videoUrl": "assets/glyphs/glyphs_video.mp4",
  };

  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset(_discoveryData['videoUrl'])
          ..initialize().then((_) {
            setState(() {
              _isVideoInitialized = true;
              _videoController.play();
              _videoController.setLooping(true);
            });
          });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onPlayGame() {
    // Stop video before opening the game
    if (_videoController.value.isPlaying) {
      _videoController.pause();
    }
    HapticFeedback.mediumImpact();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE5C687), // Light golden background
        body: SafeArea(
          child: Column(
            children: [
              // Dark curved header section
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF264653),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
                  child: Column(
                    children: [
                      // Header with back button
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _onBackPressed,
                            child: Container(
                              width: 12.w,
                              height: 12.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4AF37).withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: CustomIconWidget(
                                  iconName: 'arrow_back',
                                  color: Color(0xFFD4AF37),
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),

                      SizedBox(height: 3.h),

                      // Main title
                      Text(
                        _discoveryData['title'],
                        style: AppTheme.lightTheme.textTheme.headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22.sp,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 2.h),

                      // Welcome message / subtitle
                      Text(
                        _discoveryData['subtitle'],
                        style: AppTheme.lightTheme.textTheme.bodyLarge
                            ?.copyWith(
                              color: Colors.white70,
                              height: 1.4,
                              fontSize: 14.sp,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              // Main content scrollable
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    child: Column(
                      children: [
                        // Phone device container with video
                        Container(
                          width: 70.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF264653), // Dark phone frame
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF264653).withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.w),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: _isVideoInitialized
                                    ? FittedBox(
                                        fit: BoxFit.cover,
                                        child: SizedBox(
                                          width: _videoController.value.size.width,
                                          height: _videoController.value.size.height,
                                          child: VideoPlayer(_videoController),
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 4.h),

                        // Colored container for text content
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF264653),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF264653).withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _discoveryData['title'],
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                      color: const Color(0xFFD4AF37),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                    ),
                              ),

                              SizedBox(height: 1.h),

                              Text(
                                _discoveryData['subtitle'],
                                style: AppTheme.lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                              ),

                              SizedBox(height: 2.h),

                              Text(
                                _discoveryData['content'],
                                style: AppTheme.lightTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Colors.white70,
                                      height: 1.6,
                                      fontSize: 13.sp,
                                    ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 6.h),

                        // Play button for the game
                        GestureDetector(
                          onTap: _onPlayGame,
                          child: Container(
                            width: 60.w,
                            height: 7.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFFD4AF37),
                                  const Color(0xFFD4AF37).withOpacity(0.8),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(35),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFD4AF37).withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'العب و افهم',
                                style: AppTheme.lightTheme.textTheme.labelLarge
                                    ?.copyWith(
                                      color: const Color(0xFF264653),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                    ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

