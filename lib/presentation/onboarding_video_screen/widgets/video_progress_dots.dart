import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class VideoProgressDots extends StatelessWidget {
  final int currentIndex;
  final int totalVideos;

  const VideoProgressDots({
    super.key,
    required this.currentIndex,
    required this.totalVideos,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalVideos,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 1.w),
          width: 2.w,
          height: 2.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex
                ? AppTheme.lightTheme.colorScheme.tertiary
                : AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}
