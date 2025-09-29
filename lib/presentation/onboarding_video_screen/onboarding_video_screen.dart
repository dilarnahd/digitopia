import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/exit_confirmation_dialog.dart';
import './widgets/video_controls_overlay.dart';
import './widgets/video_loading_overlay.dart';
import './widgets/video_progress_dots.dart';

class OnboardingVideoScreen extends StatefulWidget {
  const OnboardingVideoScreen({super.key});

  @override
  State<OnboardingVideoScreen> createState() => _OnboardingVideoScreenState();
}

class _OnboardingVideoScreenState extends State<OnboardingVideoScreen>
    with TickerProviderStateMixin {
  // Video state management
  bool _isPlaying = false;
  bool _showControls = true;
  bool _isLoading = true;
  bool _isInitialized = false;
  int _currentVideoIndex = 0;
  double _progress = 0.0;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = const Duration(minutes: 2, seconds: 30);

  // Animation controllers
  late AnimationController _controlsAnimationController;
  late AnimationController _fadeAnimationController;

  // Mock video data for Egyptian cultural content
  final List<Map<String, dynamic>> _videoData = [
    {
      "id": 1,
      "title": "رحلة عبر التاريخ المصري",
      "description": "اكتشف عظمة الحضارة المصرية القديمة",
      "videoUrl":
          "https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4",
      "thumbnailUrl":
          "https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e?fm=jpg&q=60&w=3000",
      "duration": Duration(minutes: 2, seconds: 30),
      "subtitles": "اكتشف أسرار الفراعنة والحضارة المصرية العريقة",
    },
    {
      "id": 2,
      "title": "كنوز مصر المخفية",
      "description": "استكشف الآثار والمعابد المصرية",
      "videoUrl":
          "https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_2mb.mp4",
      "thumbnailUrl":
          "https://images.unsplash.com/photo-1568322445389-f64ac2515020?fm=jpg&q=60&w=3000",
      "duration": Duration(minutes: 3, seconds: 15),
      "subtitles": "تعرف على المعابد والأهرامات وأسرارها المدهشة",
    },
    {
      "id": 3,
      "title": "مصر الحديثة والتراث",
      "description": "كيف نحافظ على تراثنا في العصر الحديث",
      "videoUrl":
          "https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_5mb.mp4",
      "thumbnailUrl":
          "https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e?fm=jpg&q=60&w=3000",
      "duration": Duration(minutes: 2, seconds: 45),
      "subtitles": "اربط بين الماضي العريق والحاضر المشرق",
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeVideo();
    _startControlsTimer();
  }

  void _initializeAnimations() {
    _controlsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  Future<void> _initializeVideo() async {
    try {
      // Simulate video initialization
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
          _isInitialized = true;
          _totalDuration = _videoData[_currentVideoIndex]["duration"];
        });

        // Auto-start video playback
        _playVideo();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _showErrorMessage('حدث خطأ في تحميل الفيديو');
      }
    }
  }

  void _playVideo() {
    if (!_isInitialized) return;

    setState(() {
      _isPlaying = true;
    });

    // Simulate video progress
    _simulateVideoProgress();
  }

  void _pauseVideo() {
    setState(() {
      _isPlaying = false;
    });
  }

  void _simulateVideoProgress() {
    if (!_isPlaying || !mounted) return;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_isPlaying && mounted) {
        setState(() {
          _progress += 0.001;
          _currentPosition = Duration(
            milliseconds: (_totalDuration.inMilliseconds * _progress).round(),
          );

          // Check if video ended
          if (_progress >= 1.0) {
            _onVideoEnded();
            return;
          }
        });
        _simulateVideoProgress();
      }
    });
  }

  void _onVideoEnded() {
    setState(() {
      _isPlaying = false;
      _progress = 0.0;
      _currentPosition = Duration.zero;
    });

    // Auto-advance to next video or complete onboarding
    if (_currentVideoIndex < _videoData.length - 1) {
      _nextVideo();
    } else {
      _completeOnboarding();
    }
  }

  void _nextVideo() {
    if (_currentVideoIndex < _videoData.length - 1) {
      setState(() {
        _currentVideoIndex++;
        _progress = 0.0;
        _currentPosition = Duration.zero;
        _isLoading = true;
        _isInitialized = false;
        _totalDuration = _videoData[_currentVideoIndex]["duration"];
      });
      _initializeVideo();
    } else {
      _completeOnboarding();
    }
  }

  void _skipVideo() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    HapticFeedback.lightImpact();
    Navigator.pushReplacementNamed(context, '/home-dashboard');
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _pauseVideo();
    } else {
      _playVideo();
    }
  }

  void _onSeek(double value) {
    setState(() {
      _progress = value.clamp(0.0, 1.0);
      _currentPosition = Duration(
        milliseconds: (_totalDuration.inMilliseconds * _progress).round(),
      );
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });

    if (_showControls) {
      _startControlsTimer();
    }
  }

  void _startControlsTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: GoogleFonts.inter(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: AppTheme.lightTheme.colorScheme.tertiary,
            ),
          ),
        ),
      );
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ExitConfirmationDialog(
        onConfirm: () {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, '/login-screen');
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  void dispose() {
    _controlsAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hide status bar for cinematic experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _showExitDialog();
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                // Video player area
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _toggleControls,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: _isLoading
                          ? VideoLoadingOverlay(
                              thumbnailUrl: _videoData[_currentVideoIndex]
                                  ["thumbnailUrl"],
                              isLoading: _isLoading,
                            )
                          : _buildVideoPlayer(),
                    ),
                  ),
                ),

                // Video controls overlay
                if (_isInitialized)
                  Positioned.fill(
                    child: VideoControlsOverlay(
                      isPlaying: _isPlaying,
                      showControls: _showControls,
                      onPlayPause: _togglePlayPause,
                      onSkip: _skipVideo,
                      onNext: _nextVideo,
                      progress: _progress,
                      currentPosition: _currentPosition,
                      totalDuration: _totalDuration,
                      onSeek: _onSeek,
                    ),
                  ),

                // Progress dots
                Positioned(
                  bottom: 15.h,
                  left: 0,
                  right: 0,
                  child: VideoProgressDots(
                    currentIndex: _currentVideoIndex,
                    totalVideos: _videoData.length,
                  ),
                ),

                // Subtitles area
                if (_isInitialized && _showControls)
                  Positioned(
                    bottom: 20.h,
                    left: 4.w,
                    right: 4.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _videoData[_currentVideoIndex]["subtitles"],
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
      ),
      child: Stack(
        children: [
          // Video thumbnail as background
          Positioned.fill(
            child: CustomImageWidget(
              imageUrl: _videoData[_currentVideoIndex]["thumbnailUrl"],
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Video overlay effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Video title overlay
          if (_showControls)
            Positioned(
              top: 4.h,
              left: 4.w,
              right: 4.w,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 2.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _videoData[_currentVideoIndex]["title"],
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      _videoData[_currentVideoIndex]["description"],
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.8),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}