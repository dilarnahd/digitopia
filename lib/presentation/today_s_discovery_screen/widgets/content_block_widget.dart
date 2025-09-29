import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ContentBlockWidget extends StatelessWidget {
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final List<Map<String, dynamic>>? hotspots;
  final Function(Map<String, dynamic>)? onHotspotTap;

  const ContentBlockWidget({
    super.key,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    this.hotspots,
    this.onHotspotTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          right: BorderSide(
            color: AppTheme.lightTheme.colorScheme.tertiary,
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content text
          Text(
            content,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              height: 1.6,
              fontSize: 16.sp,
            ),
            textAlign: TextAlign.right,
          ),

          // Image if provided
          if (imageUrl != null) ...[
            SizedBox(height: 3.h),
            Container(
              width: double.infinity,
              height: 25.h,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  CustomImageWidget(
                    imageUrl: imageUrl!,
                    width: double.infinity,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                  // Hotspots overlay
                  if (hotspots != null)
                    ...hotspots!.map((hotspot) => _buildHotspot(hotspot)),
                ],
              ),
            ),
          ],

          // Video placeholder if provided
          if (videoUrl != null) ...[
            SizedBox(height: 3.h),
            Container(
              width: double.infinity,
              height: 25.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  CustomImageWidget(
                    imageUrl:
                        "https://images.unsplash.com/photo-1539650116574-75c0c6d73f6e?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
                    width: double.infinity,
                    height: 25.h,
                    fit: BoxFit.cover,
                  ),
                  // Video play overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.scaffoldBackgroundColor
                            .withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Container(
                          width: 15.w,
                          height: 15.w,
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.tertiary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.lightTheme.colorScheme.shadow
                                    .withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: CustomIconWidget(
                              iconName: 'play_arrow',
                              color: AppTheme.lightTheme.colorScheme.primary,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHotspot(Map<String, dynamic> hotspot) {
    final double left = (hotspot['x'] as double) * 100;
    final double top = (hotspot['y'] as double) * 100;

    return Positioned(
      left: left.w,
      top: top.h,
      child: GestureDetector(
        onTap: () => onHotspotTap?.call(hotspot),
        child: Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.tertiary,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.lightTheme.colorScheme.onSurface,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.colorScheme.shadow
                    .withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: CustomIconWidget(
              iconName: 'info',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}
