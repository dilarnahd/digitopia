import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class CategoryButtonWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isLocked;
  final VoidCallback onTap;

  const CategoryButtonWidget({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.isLocked,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20.w,
        height: 6.h,
        margin: EdgeInsets.symmetric(horizontal: 1.w),
        decoration: BoxDecoration(
          color: const Color(
            0xFFe5c687,
          ), // Light beige/gold color matching reference design
          borderRadius: BorderRadius.circular(
            16,
          ), // Rounded corners as per design
          border:
              isSelected
                  ? Border.all(
                    color: const Color(
                      0xFF264653,
                    ), // Dark teal border for selected state
                    width: 2,
                  )
                  : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
              color: const Color(
                0xFF264653,
              ), // Dark teal text color for contrast
              fontWeight: FontWeight.w600,
              fontSize: 12.sp, // Consistent sizing
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
