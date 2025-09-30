import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';

// ✅ Screens
import 'main_game.dart';
import '../llibrary_screen/dictlibrary.dart';
import '../interactive_timeline/interactive_timeline.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> with TickerProviderStateMixin {
  bool _hasStartedJourney = false;
  bool _isLoading = false;

  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    // Initialize the home video from assets
    _videoController = VideoPlayerController.asset('assets/videos/home_video.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _videoController.play();
        });
      });
  }

  Future<void> _onJourneyButtonPressed() async {
    try {
      if (!_hasStartedJourney) {
        setState(() {
          _hasStartedJourney = true;
        });
      }
      // ✅ navigate to main_game.dart
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainGame()),
      );
    } catch (e) {
      print('Error starting journey: $e');
    }
  }

  void _onNavigationTap(String destination) async {
    switch (destination) {
      case 'library':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DictLibraryScreen()),
        );
        break;

      case 'discovery':
        Navigator.pushNamed(context, AppRoutes.todaySDiscovery);
        break;

      case 'chatbot':
        final Uri url = Uri.parse(
            'https://www.chatbase.co/wf57UJjvXgYfyHQRSQoiu/help');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تعذر فتح الرابط')),
            );
          }
        }
        break;

      case 'timeline':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InteractiveTimeline()),
        );
        break;
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppTheme.secondaryLight,
        body: Center(
          child: CircularProgressIndicator(
            color: AppTheme.accentLight,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.secondaryLight,
      body: Column(
        children: [
          // Top curved section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.w),
                bottomRight: Radius.circular(30.w),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      'اهلا بيك في رحلتك لاكتشاف حضارتك. أصلك و تاريخك',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ),
          ),

          // Video section
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF264653),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: _isVideoInitialized
                          ? Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(
                                      width: _videoController.value.size.width,
                                      height: _videoController.value.size.height,
                                      child: VideoPlayer(_videoController),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: IconButton(
                                    icon: Icon(
                                      _videoController.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _videoController.value.isPlaying
                                            ? _videoController.pause()
                                            : _videoController.play();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Journey button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: GestureDetector(
              onTap: _onJourneyButtonPressed,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  color: AppTheme.accentLight,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accentLight.withAlpha(102),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Text(
                  _hasStartedJourney
                      ? 'يلا تكمل رحلتك'
                      : 'أبدأ رحلتك عبر تاريخ مصر',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryLight,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          // Bottom curved nav bar
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.w),
                topRight: Radius.circular(35.w),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavigationButton(
                    icon: Icons.menu_book,
                    onTap: () => _onNavigationTap('library'),
                  ),
                  _buildNavigationButton(
                    icon: Icons.auto_awesome,
                    onTap: () => _onNavigationTap('discovery'),
                  ),
                  _buildNavigationButton(
                    icon: Icons.chat_bubble_outline,
                    onTap: () => _onNavigationTap('chatbot'),
                  ),
                  _buildNavigationButton(
                    icon: Icons.timeline,
                    onTap: () => _onNavigationTap('timeline'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 15.w,
        height: 15.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.accentLight, width: 2),
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppTheme.accentLight,
            size: 7.w,
          ),
        ),
      ),
    );
  }
}
