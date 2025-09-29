import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DiscoveryPreviewModalWidget extends StatelessWidget {
  final Map<String, dynamic> discoveryData;
  final VoidCallback onReadNow;
  final VoidCallback onSaveForLater;

  const DiscoveryPreviewModalWidget({
    super.key,
    required this.discoveryData,
    required this.onReadNow,
    required this.onSaveForLater,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: 70.h,
        minHeight: 40.h,
      ),
      decoration: BoxDecoration(
        color: AppTheme.cardLight,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(
          color: AppTheme.accentLight,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 1.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.accentLight.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomImageWidget(
                      imageUrl: discoveryData['image'] as String,
                      width: double.infinity,
                      height: 25.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Category and rating
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.accentLight.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.accentLight,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          discoveryData['category'] as String,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.accentLight,
                            fontWeight: FontWeight.w600,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      const Spacer(),
                      CustomIconWidget(
                        iconName: 'star',
                        color: AppTheme.accentLight,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${discoveryData['rating']}',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.textPrimaryLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.5.h),

                  // Title
                  Text(
                    discoveryData['title'] as String,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.textPrimaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 1.h),

                  // Description
                  Text(
                    discoveryData['fullDescription'] as String,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondaryLight,
                      height: 1.5,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 2.h),

                  // Read time and difficulty
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'schedule',
                        color: AppTheme.accentLight,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${discoveryData['readTime']} دقائق قراءة',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.textSecondaryLight,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(width: 4.w),
                      CustomIconWidget(
                        iconName: 'trending_up',
                        color: AppTheme.accentLight,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        discoveryData['difficulty'] as String,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.textSecondaryLight,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),

          // Action buttons
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppTheme.accentLight.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      onSaveForLater();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      side: BorderSide(
                        color: AppTheme.accentLight,
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'bookmark_border',
                          color: AppTheme.accentLight,
                          size: 18,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'احفظ للاحقاً',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppTheme.accentLight,
                            fontWeight: FontWeight.w600,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      onReadNow();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      backgroundColor: AppTheme.accentLight,
                      foregroundColor: AppTheme.primaryLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'play_arrow',
                          color: AppTheme.primaryLight,
                          size: 18,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'اقرأ الآن',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppTheme.primaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),
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
