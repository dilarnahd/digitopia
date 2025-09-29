import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class KnowledgeQuizWidget extends StatefulWidget {
  final Map<String, dynamic> quizData;
  final Function(bool, int) onAnswerSelected;

  const KnowledgeQuizWidget({
    super.key,
    required this.quizData,
    required this.onAnswerSelected,
  });

  @override
  State<KnowledgeQuizWidget> createState() => _KnowledgeQuizWidgetState();
}

class _KnowledgeQuizWidgetState extends State<KnowledgeQuizWidget>
    with TickerProviderStateMixin {
  int? _selectedAnswer;
  bool _showResult = false;
  late AnimationController _celebrationController;
  late Animation<double> _celebrationAnimation;

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _celebrationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _celebrationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  void _selectAnswer(int index) {
    if (_showResult) return;

    HapticFeedback.lightImpact();
    setState(() {
      _selectedAnswer = index;
      _showResult = true;
    });

    final isCorrect = index == (widget.quizData['correctAnswer'] as int);
    final points = isCorrect ? (widget.quizData['points'] as int) : 0;

    if (isCorrect) {
      _celebrationController.forward();
      HapticFeedback.heavyImpact();
    }

    widget.onAnswerSelected(isCorrect, points);
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quizData['question'] as String;
    final options = widget.quizData['options'] as List<String>;
    final correctAnswer = widget.quizData['correctAnswer'] as int;
    final points = widget.quizData['points'] as int;

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
          // Quiz header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.tertiary
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: CustomIconWidget(
                  iconName: 'quiz',
                  color: AppTheme.lightTheme.colorScheme.tertiary,
                  size: 24,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اختبر معلوماتك',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$points نقطة',
                      style:
                          AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.tertiary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Celebration animation
              if (_showResult && _selectedAnswer == correctAnswer)
                AnimatedBuilder(
                  animation: _celebrationAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _celebrationAnimation.value,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconWidget(
                          iconName: 'star',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 20,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),

          SizedBox(height: 3.h),

          // Question
          Text(
            question,
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            textAlign: TextAlign.right,
          ),

          SizedBox(height: 3.h),

          // Answer options
          ...options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isSelected = _selectedAnswer == index;
            final isCorrect = index == correctAnswer;
            final isWrong = _showResult && isSelected && !isCorrect;

            Color backgroundColor = AppTheme.lightTheme.colorScheme.surface;
            Color borderColor =
                AppTheme.lightTheme.colorScheme.tertiary.withValues(alpha: 0.3);
            Color textColor = AppTheme.lightTheme.colorScheme.onSurface;

            if (_showResult) {
              if (isCorrect) {
                backgroundColor = AppTheme.lightTheme.colorScheme.tertiary
                    .withValues(alpha: 0.2);
                borderColor = AppTheme.lightTheme.colorScheme.tertiary;
                textColor = AppTheme.lightTheme.colorScheme.tertiary;
              } else if (isWrong) {
                backgroundColor = AppTheme.lightTheme.colorScheme.error
                    .withValues(alpha: 0.1);
                borderColor = AppTheme.lightTheme.colorScheme.error;
                textColor = AppTheme.lightTheme.colorScheme.error;
              }
            } else if (isSelected) {
              backgroundColor = AppTheme.lightTheme.colorScheme.tertiary
                  .withValues(alpha: 0.1);
              borderColor = AppTheme.lightTheme.colorScheme.tertiary;
            }

            return Container(
              margin: EdgeInsets.only(bottom: 2.h),
              child: GestureDetector(
                onTap: () => _selectAnswer(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: borderColor,
                      width: isSelected || (_showResult && isCorrect) ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Option letter
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: borderColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: borderColor,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            String.fromCharCode(65 + index), // A, B, C, D
                            style: AppTheme.lightTheme.textTheme.labelLarge
                                ?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      // Option text
                      Expanded(
                        child: Text(
                          option,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      // Result icon
                      if (_showResult && (isCorrect || isWrong)) ...[
                        SizedBox(width: 2.w),
                        CustomIconWidget(
                          iconName: isCorrect ? 'check_circle' : 'cancel',
                          color: isCorrect
                              ? AppTheme.lightTheme.colorScheme.tertiary
                              : AppTheme.lightTheme.colorScheme.error,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }).toList(),

          // Result message
          if (_showResult) ...[
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: _selectedAnswer == correctAnswer
                    ? AppTheme.lightTheme.colorScheme.tertiary
                        .withValues(alpha: 0.1)
                    : AppTheme.lightTheme.colorScheme.error
                        .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _selectedAnswer == correctAnswer
                      ? AppTheme.lightTheme.colorScheme.tertiary
                      : AppTheme.lightTheme.colorScheme.error,
                  width: 1,
                ),
              ),
              child: Text(
                _selectedAnswer == correctAnswer
                    ? 'ممتاز! لقد حصلت على $points نقطة'
                    : 'إجابة خاطئة، حاول مرة أخرى في المرة القادمة',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: _selectedAnswer == correctAnswer
                      ? AppTheme.lightTheme.colorScheme.tertiary
                      : AppTheme.lightTheme.colorScheme.error,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
