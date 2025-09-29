import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class VideoControlsOverlay extends StatelessWidget {
  final bool isPlaying;
  final bool showControls;
  final VoidCallback onPlayPause;
  final VoidCallback onSkip;
  final VoidCallback onNext;
  final double progress;
  final Duration currentPosition;
  final Duration totalDuration;
  final Function(double) onSeek;

  const VideoControlsOverlay({
    super.key,
    required this.isPlaying,
    required this.showControls,
    required this.onPlayPause,
    required this.onSkip,
    required this.onNext,
    required this.progress,
    required this.currentPosition,
    required this.totalDuration,
    required this.onSeek,
  });

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showControls ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.7),
              Colors.transparent,
              Colors.transparent,
              Colors.black.withValues(alpha: 0.8),
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Column(
          children: [
            // Top gradient area
            Expanded(flex: 2, child: Container()),

            // Center play/pause button
            Expanded(
              flex: 3,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onPlayPause();
                  },
                  child: Container(
                    width: 15.w,
                    height: 15.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.lightTheme.colorScheme.tertiary
                          .withValues(alpha: 0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CustomIconWidget(
                      iconName: isPlaying ? 'pause' : 'play_arrow',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 8.w,
                    ),
                  ),
                ),
              ),
            ),

            // Bottom controls area
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  children: [
                    // Progress bar
                    Row(
                      children: [
                        Text(
                          _formatDuration(currentPosition),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor:
                                  AppTheme.lightTheme.colorScheme.tertiary,
                              inactiveTrackColor: AppTheme
                                  .lightTheme.colorScheme.onSurface
                                  .withValues(alpha: 0.3),
                              thumbColor:
                                  AppTheme.lightTheme.colorScheme.tertiary,
                              overlayColor: AppTheme
                                  .lightTheme.colorScheme.tertiary
                                  .withValues(alpha: 0.2),
                              trackHeight: 0.5.h,
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 1.5.w),
                            ),
                            child: Slider(
                              value: progress.clamp(0.0, 1.0),
                              onChanged: onSeek,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          _formatDuration(totalDuration),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 3.h),

                    // Control buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Skip button (left in RTL)
                        TextButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            onSkip();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor:
                                AppTheme.lightTheme.colorScheme.onSurface,
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.5.h),
                          ),
                          child: Text(
                            'تخطي',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        // Next button (right in RTL)
                        ElevatedButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            onNext();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                AppTheme.lightTheme.colorScheme.tertiary,
                            foregroundColor:
                                AppTheme.lightTheme.colorScheme.primary,
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 1.5.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'التالي',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 1.w),
                              CustomIconWidget(
                                iconName: 'arrow_back_ios',
                                color: AppTheme.lightTheme.colorScheme.primary,
                                size: 4.w,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
