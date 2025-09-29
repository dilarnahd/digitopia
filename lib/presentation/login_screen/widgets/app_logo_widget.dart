import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Golden accents - Left
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 12.w,
              height: 0.3.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD4AF37),
                    const Color(0xFFD4AF37).withValues(alpha: 0.3),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              width: 12.w,
              height: 0.3.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD4AF37).withValues(alpha: 0.3),
                    const Color(0xFFD4AF37),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),

        SizedBox(height: 2.h),

        // User's Logo Image - Made bigger
        Container(
          width: 35.w, // Increased from 25.w
          height: 35.w, // Increased from 25.w
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/logo-1758648320376.png',
              width: 35.w,
              height: 35.w,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 35.w,
                  height: 35.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF264653),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.white,
                    size: 15.w,
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(height: 3.h),

        // App Name - Changed to Arabic
        Text(
          'انت مين',
          style: GoogleFonts.amiri(
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF264653),
            letterSpacing: 1.0,
          ),
        ),

        SizedBox(height: 1.h),

        // App Tagline
        Text(
          'اكتشف شخصيتك الحقيقية',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF264653).withValues(alpha: 0.8),
          ),
        ),

        SizedBox(height: 2.h),

        // Golden accents - Bottom
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 12.w,
              height: 0.3.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD4AF37),
                    const Color(0xFFD4AF37).withValues(alpha: 0.3),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              width: 12.w,
              height: 0.3.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFD4AF37).withValues(alpha: 0.3),
                    const Color(0xFFD4AF37),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
