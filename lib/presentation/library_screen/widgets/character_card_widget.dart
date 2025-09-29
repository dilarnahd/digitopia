import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CharacterCardWidget extends StatelessWidget {
  final Map<String, dynamic> character;

  const CharacterCardWidget({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLocked = character['isLocked'] ?? false;

    return Container(
      // Remove extra container styling since parent already has dark background
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Character image
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2), // Light border
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: isLocked
                  ? Container(
                      color: Colors.white.withValues(alpha: 0.1),
                      child: Center(
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.white.withValues(alpha: 0.7),
                          size: 24,
                        ),
                      ),
                    )
                  : CustomImageWidget(
                      imageUrl: character['imageUrl'] ?? '',
                      fit: BoxFit.cover,
                      errorWidget: Container(
                        color: Colors.white.withValues(alpha: 0.1),
                        child: Center(
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white.withValues(alpha: 0.7),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
            ),
          ),

          SizedBox(width: 4.w),

          // Character details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Name
                Text(
                  character['name'] ?? 'غير معروف',
                  textAlign: TextAlign.right,
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: Colors.white, // White color for dark background
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 1.h),

                // Era
                Text(
                  character['era'] ?? 'غير محدد',
                  textAlign: TextAlign.right,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8), // Light white
                  ),
                ),

                SizedBox(height: 0.5.h),

                // Tagline
                Text(
                  character['tagline'] ?? '',
                  textAlign: TextAlign.right,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7), // Light white
                    fontStyle: FontStyle.italic,
                  ),
                ),

                SizedBox(height: 1.h),

                // Description
                Text(
                  character['description'] ?? 'لا يوجد وصف متاح',
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9), // Light white
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}