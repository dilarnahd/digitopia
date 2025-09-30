import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class ShimmerLoadingWidget extends StatefulWidget {
  const ShimmerLoadingWidget({Key? key}) : super(key: key);

  @override
  State<ShimmerLoadingWidget> createState() => _ShimmerLoadingWidgetState();
}

class _ShimmerLoadingWidgetState extends State<ShimmerLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppTheme.lightTheme.colorScheme.shadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                // Shimmer image placeholder
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Container(
                      width: 15.w,
                      height: 15.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment(_animation.value - 1, 0),
                          end: Alignment(_animation.value, 0),
                          colors: [
                            AppTheme.lightTheme.colorScheme.secondary
                                .withValues(alpha: 0.3),
                            AppTheme.lightTheme.colorScheme.secondary
                                .withValues(alpha: 0.5),
                            AppTheme.lightTheme.colorScheme.secondary
                                .withValues(alpha: 0.3),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(width: 3.w),

                // Shimmer text placeholders
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Name placeholder
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Container(
                            height: 2.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                begin: Alignment(_animation.value - 1, 0),
                                end: Alignment(_animation.value, 0),
                                colors: [
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.3),
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.5),
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.3),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 1.h),

                      // Era placeholder
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Container(
                            height: 1.5.h,
                            width: 25.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                begin: Alignment(_animation.value - 1, 0),
                                end: Alignment(_animation.value, 0),
                                colors: [
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.3),
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.5),
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.3),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 1.h),

                      // Tagline placeholder
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Container(
                            height: 1.5.h,
                            width: 60.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              gradient: LinearGradient(
                                begin: Alignment(_animation.value - 1, 0),
                                end: Alignment(_animation.value, 0),
                                colors: [
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.3),
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.5),
                                  AppTheme.lightTheme.colorScheme.secondary
                                      .withValues(alpha: 0.3),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
