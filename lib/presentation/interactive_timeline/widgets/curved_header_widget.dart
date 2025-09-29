import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

/// Curved header widget for the timeline screen
/// Implements dark teal background with Arabic title and return button
class CurvedHeaderWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBackPressed;

  const CurvedHeaderWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 30.h,
      child: Stack(
        children: [
          // Curved background
          CustomPaint(
            size: Size(100.w, 30.h),
            painter: CurvedHeaderPainter(
              color: const Color(0xFF264653),
            ),
          ),

          // Header content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                children: [
                  // Top row with back button on the left
                  Row(
                    children: [
                      // Return button (left side) - Points right for RTL
                      IconButton(
                        onPressed:
                            onBackPressed ?? () => Navigator.of(context).pop(),
                        icon: CustomIconWidget(
                          iconName: 'arrow_forward',
                          color: const Color(0xFFe5c687),
                          size: 24,
                        ),
                        tooltip: 'ارجع',
                      ),
                      Spacer(),
                    ],
                  ),

                  Spacer(),

                  // Centered title with proper alignment within curve
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 1.h,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          // Main encouraging title
                          Text(
                            title,
                            style: theme.textTheme.headlineLarge?.copyWith(
                              color: const Color(0xFFe5c687),
                              fontWeight: FontWeight.w600,
                              fontSize: 24.sp,
                              height: 1.3,
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                          ),

                          if (subtitle != null) ...[
                            SizedBox(height: 2.h),
                            // Subtitle description
                            Text(
                              subtitle!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFFe5c687)
                                    .withValues(alpha: 0.9),
                                fontSize: 14.sp,
                                height: 1.4,
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for curved header background
class CurvedHeaderPainter extends CustomPainter {
  final Color color;

  CurvedHeaderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from top-left
    path.moveTo(0, 0);

    // Top edge
    path.lineTo(size.width, 0);

    // Right edge - extended for bigger curve
    path.lineTo(size.width, size.height * 0.75);

    // Bigger curved bottom edge
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 1.1,
      0,
      size.height * 0.75,
    );

    // Left edge back to start
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
