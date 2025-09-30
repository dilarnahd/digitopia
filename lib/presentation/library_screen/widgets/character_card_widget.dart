import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CharacterCardWidget extends StatelessWidget {
  final Map<String, dynamic> character;

  const CharacterCardWidget({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLocked = character['isLocked'] ?? false;
    final String? imageAsset = character['imageAsset'];

    return Container(
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Character image square
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: isLocked
                  ? Container(
                      color: Colors.white.withOpacity(0.1),
                      child: Center(
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.white.withOpacity(0.7),
                          size: 24,
                        ),
                      ),
                    )
                  : imageAsset != null && imageAsset.endsWith('.svg')
                      ? SvgPicture.asset(
                          imageAsset,
                          fit: BoxFit.contain,
                          placeholderBuilder: (context) => Container(
                            color: Colors.white.withOpacity(0.1),
                            child: Center(
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.white.withOpacity(0.7),
                                size: 24,
                              ),
                            ),
                          ),
                        )
                      : Image.asset(
                          imageAsset ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.white.withOpacity(0.1),
                            child: Center(
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.white.withOpacity(0.7),
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
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 1.h),

                // Era
                Text(
                  character['era'] ?? 'غير محدد',
                  textAlign: TextAlign.right,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),

                SizedBox(height: 0.5.h),

                // Tagline
                Text(
                  character['tagline'] ?? '',
                  textAlign: TextAlign.right,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withOpacity(0.7),
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
                    color: Colors.white.withOpacity(0.9),
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
