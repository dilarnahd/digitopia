import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class VideoLoadingOverlay extends StatelessWidget {
  final String thumbnailUrl;
  final bool isLoading;

  const VideoLoadingOverlay({
    super.key,
    required this.thumbnailUrl,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
      ),
      child: Stack(
        children: [
          // Thumbnail background
          if (thumbnailUrl.isNotEmpty)
            Positioned.fill(
              child: CustomImageWidget(
                imageUrl: thumbnailUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          // Dark overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),

          // Loading indicator
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 12.w,
                    height: 12.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 0.8.w,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.lightTheme.colorScheme.tertiary,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'جاري التحميل...',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
