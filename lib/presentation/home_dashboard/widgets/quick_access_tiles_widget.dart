import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickAccessTilesWidget extends StatelessWidget {
  final Function(String) onTileTap;

  const QuickAccessTilesWidget({
    super.key,
    required this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tiles = [
      {
        'title': 'المكتبة',
        'subtitle': 'المحتوى المفتوح',
        'icon': 'library_books',
        'route': '/library-screen',
        'badge': '24',
      },
      {
        'title': 'الخط الزمني',
        'subtitle': 'التاريخ المصري',
        'icon': 'timeline',
        'route': '/timeline-screen',
        'badge': null,
      },
      {
        'title': 'الملف الشخصي',
        'subtitle': 'إعدادات الحساب',
        'icon': 'person',
        'route': '/player-info-collection-screen',
        'badge': null,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.w),
          child: Text(
            'الوصول السريع',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
            textDirection: TextDirection.rtl,
          ),
        ),
        SizedBox(height: 2.h),
        ...tiles.map((tile) => _buildQuickAccessTile(context, tile)),
      ],
    );
  }

  Widget _buildQuickAccessTile(
      BuildContext context, Map<String, dynamic> tile) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            onTileTap(tile['route'] as String);
          },
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 8.h),
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
            child: Row(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: AppTheme.accentLight.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.accentLight,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: CustomIconWidget(
                      iconName: tile['icon'] as String,
                      color: AppTheme.accentLight,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tile['title'] as String,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.primaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        tile['subtitle'] as String,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryLight.withValues(alpha: 0.7),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                if (tile['badge'] != null) ...[
                  SizedBox(width: 2.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.accentLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tile['badge'] as String,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.primaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                SizedBox(width: 2.w),
                CustomIconWidget(
                  iconName: 'arrow_back_ios',
                  color: AppTheme.accentLight,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
