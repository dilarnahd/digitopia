import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

/// Timeline block widget representing a historical era
/// Implements alternating left-right positioning with Arabic text support
class TimelineBlockWidget extends StatelessWidget {
  final Map<String, dynamic> eraData;
  final bool isLeftAligned;
  final VoidCallback? onGoPressed;

  const TimelineBlockWidget({
    super.key,
    required this.eraData,
    required this.isLeftAligned,
    this.onGoPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          // Left side content or spacer
          Expanded(
            child: isLeftAligned
                ? _buildTimelineBlock(context, isDark)
                : SizedBox.shrink(),
          ),

          // Center connector dot
          Container(
            width: 4.w,
            height: 4.w,
            decoration: BoxDecoration(
              color: const Color(0xFFe5c687), // Updated color
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    isDark ? const Color(0xFF264653) : const Color(0xFF264653),
                width: 2,
              ),
            ),
          ),

          // Right side content or spacer
          Expanded(
            child: !isLeftAligned
                ? _buildTimelineBlock(context, isDark)
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineBlock(BuildContext context, bool isDark) {
    final theme = Theme.of(context);
    const Color blockColor = Color(0xFF264653);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: blockColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppTheme.shadowDark : AppTheme.shadowLight,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Era title in white
          Text(
            (eraData['title'] as String?) ?? '',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white, // Changed to white
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
            textDirection: TextDirection.rtl,
          ),

          SizedBox(height: 1.h),

          // Era period in white
          Text(
            (eraData['period'] as String?) ?? '',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white
                  .withValues(alpha: 0.8), // Changed to white with opacity
              fontSize: 12.sp,
            ),
            textDirection: TextDirection.rtl,
          ),

          SizedBox(height: 2.h),

          // Go button with white text
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onGoPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe5c687),
                foregroundColor: Colors.white, // Changed button text to white
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              child: Text(
                'يلا',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
