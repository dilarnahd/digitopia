import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class DifficultySliderWidget extends StatelessWidget {
  final double difficultyLevel;
  final Function(double) onDifficultyChanged;

  const DifficultySliderWidget({
    super.key,
    required this.difficultyLevel,
    required this.onDifficultyChanged,
  });

  static const List<String> difficultyLabels = [
    'مبتدئ',
    'متوسط',
    'متقدم',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          right: BorderSide(
            color: AppTheme.lightTheme.colorScheme.tertiary,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مستوى الصعوبة المفضل',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'اختار مستوى التحدي اللي يناسبك',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 3.h),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: difficultyLabels.asMap().entries.map((entry) {
                  final index = entry.key;
                  final label = entry.value;
                  final isSelected = difficultyLevel.round() == index;

                  return Text(
                    label,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.tertiary
                          : AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.7),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 2.h),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: AppTheme.lightTheme.colorScheme.tertiary,
                  inactiveTrackColor: AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.3),
                  thumbColor: AppTheme.lightTheme.colorScheme.tertiary,
                  overlayColor: AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.2),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: difficultyLevel,
                  min: 0,
                  max: 2,
                  divisions: 2,
                  onChanged: onDifficultyChanged,
                ),
              ),
              SizedBox(height: 1.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.tertiary
                        .withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  _getDifficultyDescription(difficultyLevel.round()),
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDifficultyDescription(int level) {
    switch (level) {
      case 0:
        return 'مناسب للمبتدئين - أسئلة بسيطة ومعلومات أساسية';
      case 1:
        return 'مستوى متوسط - تحديات معتدلة ومعلومات متنوعة';
      case 2:
        return 'مستوى متقدم - تحديات صعبة ومعلومات تفصيلية';
      default:
        return '';
    }
  }
}
