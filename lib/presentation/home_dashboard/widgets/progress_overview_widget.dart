import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProgressOverviewWidget extends StatelessWidget {
  final Map<String, dynamic> progressData;

  const ProgressOverviewWidget({
    super.key,
    required this.progressData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.secondaryLight,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          right: BorderSide(
            color: AppTheme.accentLight,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'trending_up',
                color: AppTheme.accentLight,
                size: 24,
              ),
              SizedBox(width: 2.w),
              Text(
                'إنجازاتك',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryLight,
                  fontWeight: FontWeight.w600,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: _buildProgressItem(
                  context,
                  'المحتوى المفتوح',
                  '${progressData['unlockedContent']}',
                  '${progressData['totalContent']}',
                  'library_books',
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: _buildProgressItem(
                  context,
                  'الإنجازات',
                  '${progressData['achievements']}',
                  '${progressData['totalAchievements']}',
                  'emoji_events',
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Container(
            width: double.infinity,
            height: 1.h,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerRight,
              widthFactor: (progressData['unlockedContent'] as int) /
                  (progressData['totalContent'] as int),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.accentLight,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'مستوى ${progressData['level']} - ${((progressData['unlockedContent'] as int) / (progressData['totalContent'] as int) * 100).toInt()}% مكتمل',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryLight.withValues(alpha: 0.8),
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(
    BuildContext context,
    String title,
    String current,
    String total,
    String iconName,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.accentLight.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: AppTheme.accentLight,
            size: 20,
          ),
          SizedBox(height: 1.h),
          Text(
            '$current/$total',
            style: theme.textTheme.titleSmall?.copyWith(
              color: AppTheme.primaryLight,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 0.5.h),
          Text(
            title,
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppTheme.primaryLight.withValues(alpha: 0.8),
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
