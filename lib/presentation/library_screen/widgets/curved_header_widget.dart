import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CurvedHeaderWidget extends StatelessWidget {
  final VoidCallback onHomeTap;

  const CurvedHeaderWidget({Key? key, required this.onHomeTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25.h,
      child: Stack(
        children: [
          // Curved background with dark teal color
          ClipPath(
            clipper: CurvedHeaderClipper(),
            child: Container(
              height: 25.h,
              decoration: const BoxDecoration(
                color: Color(0xFF264653), // Dark teal background
              ),
            ),
          ),

          // Header content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // RTL alignment
                children: [
                  // Single return button positioned on top right
                  Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Top right in RTL
                    children: [
                      GestureDetector(
                        onTap: onHomeTap,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFFe5c687), // Light beige/gold background
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const CustomIconWidget(
                            iconName: 'arrow_back',
                            color: Color(0xFF264653), // Dark teal icon color
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 3.h),

                  // Welcome title and subtitle matching attachment
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // RTL alignment
                    children: [
                      Text(
                        'أهلا بيك في مكتبتك !',
                        textAlign: TextAlign.right, // Proper RTL alignment
                        style: AppTheme.lightTheme.textTheme.headlineMedium
                            ?.copyWith(
                          color: Colors.white, // White color for contrast
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'هنا هتلاقي كل المعلومات اللي انت فتحتها و انت بتلعب',
                        textAlign: TextAlign.right, // Proper RTL alignment
                        style:
                            AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(
                              alpha: 0.8), // Light white with transparency
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);

    // Create curved bottom
    var firstControlPoint = Offset(size.width * 0.25, size.height);
    var firstEndPoint = Offset(size.width * 0.5, size.height - 20);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 0.75, size.height - 40);
    var secondEndPoint = Offset(size.width, size.height - 20);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
