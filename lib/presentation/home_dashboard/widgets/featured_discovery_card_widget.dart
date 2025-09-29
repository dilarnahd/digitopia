import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FeaturedDiscoveryCardWidget extends StatelessWidget {
  final Map<String, dynamic> discoveryData;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const FeaturedDiscoveryCardWidget({
    super.key,
    required this.discoveryData,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.secondaryLight,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            right: BorderSide(
              color: AppTheme.accentLight,
              width: 4,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: CustomImageWidget(
                imageUrl: discoveryData['image'] as String,
                width: double.infinity,
                height: 20.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          color: AppTheme.primaryLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    discoveryData['title'] as String,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.primaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    discoveryData['description'] as String,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryLight.withValues(alpha: 0.8),
                    ),
                    textDirection: TextDirection.rtl,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 1.5.h),
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
                          color: AppTheme.primaryLight.withValues(alpha: 0.7),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 0.8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.accentLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'اقرأ الآن',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: AppTheme.primaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
