import 'package:egyptquest/presentation/today_s_discovery_screen/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import 'game.dart';

class TodaySDiscoveryScreen extends StatefulWidget {
  const TodaySDiscoveryScreen({super.key});

  @override
  State<TodaySDiscoveryScreen> createState() => _TodaySDiscoveryScreenState();
}

class _TodaySDiscoveryScreenState extends State<TodaySDiscoveryScreen>
    with TickerProviderStateMixin {
  // Mock discovery data
  final Map<String, dynamic> _discoveryData = {
    "id": 1,
    "title": "أسرار الهرم الأكبر",
    "subtitle": "معجزة الهندسة المصرية القديمة",
    "content":
        "اكتشف أسرار بناء الهرم الأكبر وكيف استطاع المصريون القدماء بناء هذا الصرح العظيم بدقة هندسية مذهلة تحير العلماء حتى اليوم. استخدموا تقنيات متطورة ونظم معقدة من المنحدرات والبكرات.",
    "videoUrl": "assets/glyphs/glyphs_video.mp4", // Local asset
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

  void _playVideo() {
    if (_isVideoInitialized) {
      _videoController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE5C687),
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
                      Text(
                        'اكتشاف اليوم!',
                        style: AppTheme.lightTheme.textTheme.headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 22.sp,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'اكتشف أسرارًا جديدة من حضارتك العريقة',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    child: Column(
                      children: [
                        // Phone device container with video
                        Container(
                          width: 70.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF264653),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF264653).withOpacity(0.3),
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
                              child: Padding(
                                padding: EdgeInsets.all(4.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Video player / play button
                                    GestureDetector(
                                      onTap: _playVideo,
                                      child: _isVideoInitialized
                                          ? AspectRatio(
                                              aspectRatio:
                                                  _videoController.value
                                                      .aspectRatio,
                                              child: VideoPlayer(_videoController),
                                            )
                                          : Container(
                                              width: 20.w,
                                              height: 20.w,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF264653)
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Center(
                                                child: CustomIconWidget(
                                                  iconName: 'play_circle_filled',
                                                  color: Color(0xFF264653),
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                    ),

                                    SizedBox(height: 3.h),
                                    Text(
                                      'الاخر ج',
                                      style: AppTheme.lightTheme.textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            color: const Color(0xFF264653),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.sp,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),

                                    SizedBox(height: 2.h),

                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: 1.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD4AF37)
                                            .withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '5:30 دقيقة',
                                        style: AppTheme.lightTheme.textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: const Color(0xFF264653),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.sp,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 4.h),

                        // Text content container
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF264653),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xFF264653).withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _discoveryData['title'] as String,
                                style: AppTheme.lightTheme.textTheme.titleLarge
                                    ?.copyWith(
                                      color: const Color(0xFFD4AF37),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                    ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                _discoveryData['subtitle'] as String,
                                style: AppTheme.lightTheme.textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                _discoveryData['content'] as String,
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

                        // Play game button
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const GameScreen()),
                            );
                          },
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
