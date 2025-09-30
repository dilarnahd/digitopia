import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المكتبة"),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: characters.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final character = characters[index];
          return Card(
            color: Colors.black.withOpacity(0.7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CharacterCardWidget(character: character),
            ),
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }
}


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

// Example characters list (replace/add as needed)
final List<Map<String, dynamic>> characters = [
  {
    'name': 'حرب أكتوبر',
    'era': '1973',
    'tagline': 'العبور العظيم',
    'description': 'انتصار الجيش المصري على العدو في حرب أكتوبر.',
    'imageAsset': 'assets/images/6th_october.svg',
    'isLocked': false,
  },
  {
    'name': 'القاهرة من البرج',
    'era': 'القرن العشرين',
    'tagline': 'القاهرة الحديثة',
    'description': 'منظر بانورامي للعاصمة المصرية من برج القاهرة.',
    'imageAsset': 'assets/images/Cairo_from_Tower_(cropped).svg',
    'isLocked': false,
  },
  {
    'name': 'معركة عين جالوت',
    'era': '1260',
    'tagline': 'النصر على المغول',
    'description': 'أول انتصار حاسم على المغول بقيادة السلطان قطز.',
    'imageAsset': 'assets/images/Campaign_of_the_Battle_of_Ain_Jalut-1260.svg',
    'isLocked': false,
  },
  {
    'name': 'الكهرباء',
    'era': 'العصر الحديث',
    'tagline': 'النهضة التكنولوجية',
    'description': 'بداية كهربة مصر وتطور البنية التحتية.',
    'imageAsset': 'assets/images/electricity.svg',
    'isLocked': false,
  },
  {
    'name': 'جمال عبد الناصر',
    'era': '1952–1970',
    'tagline': 'زعيم الثورة',
    'description': 'أحد أبرز زعماء مصر في العصر الحديث.',
    'imageAsset': 'assets/images/Gamal_Abdel_Naser_u_Beogradu_1962.svg',
    'isLocked': false,
  },
  {
    'name': 'هرم خوفو',
    'era': '2600 ق.م',
    'tagline': 'أعجوبة الدنيا',
    'description': 'أكبر أهرامات الجيزة وباقٍ حتى اليوم.',
    'imageAsset': 'assets/images/Great_Pyramid_of_Giza_-_Pyramid_of_Khufu.svg',
    'isLocked': false,
  },
  {
    'name': 'السد العالي',
    'era': '1960',
    'tagline': 'مشروع القرن',
    'description': 'أحد أهم مشاريع مصر التنموية.',
    'imageAsset': 'assets/images/high_dam.svg',
    'isLocked': false,
  },
  {
    'name': 'حسين هيكل',
    'era': 'القرن العشرين',
    'tagline': 'المؤرخ والصحفي',
    'description': 'من أبرز المفكرين والصحفيين المصريين.',
    'imageAsset': 'assets/images/hussein_heki.svg',
    'isLocked': false,
  },
  {
    'name': 'معركة قادش',
    'era': '1274 ق.م',
    'tagline': 'رمسيس الثاني ضد الحيثيين',
    'description': 'واحدة من أشهر المعارك في التاريخ المصري القديم.',
    'imageAsset': 'assets/images/Kadesh.svg',
    'isLocked': false,
  },
  {
    'name': 'الملك نارمر',
    'era': '3100 ق.م',
    'tagline': 'موحد القطرين',
    'description': 'أول ملوك مصر الموحدة.',
    'imageAsset': 'assets/images/King_Narmer.svg',
    'isLocked': false,
  },
  {
    'name': 'كليوباترا',
    'era': '69–30 ق.م',
    'tagline': 'آخر ملوك البطالمة',
    'description': 'أشهر ملكات مصر وأكثرهن تأثيراً.',
    'imageAsset': 'assets/images/Kleopatra-VII.-Altes-Museum-Berlin1.svg',
    'isLocked': false,
  },
  {
    'name': 'البردي',
    'era': 'العصر الفرعوني',
    'tagline': 'ورق المصريين القدماء',
    'description': 'أداة الكتابة الأساسية في مصر القديمة.',
    'imageAsset': 'assets/images/papyrus.svg',
    'isLocked': false,
  },
  {
    'name': 'رمسيس الثاني',
    'era': '1279–1213 ق.م',
    'tagline': 'أعظم فراعنة مصر',
    'description': 'قائد عسكري وباني عظيم.',
    'imageAsset': 'assets/images/Ramses_II_British_Museum.svg',
    'isLocked': false,
  },
  {
    'name': 'قناة السويس',
    'era': '1869',
    'tagline': 'شريان التجارة العالمية',
    'description': 'واحدة من أهم الممرات المائية في العالم.',
    'imageAsset': 'assets/images/suez_canal.svg',
    'isLocked': false,
  },
  // Leave the last 2 placeholders as is
  {
    'name': 'قريباً',
    'era': '...',
    'tagline': 'بطاقة قيد الإضافة',
    'description': 'لا يوجد وصف متاح',
    'imageAsset': 'assets/images/placeholder1.svg',
    'isLocked': true,
  },
  {
    'name': 'قريباً',
    'era': '...',
    'tagline': 'بطاقة قيد الإضافة',
    'description': 'لا يوجد وصف متاح',
    'imageAsset': 'assets/images/placeholder2.svg',
    'isLocked': true,
  },
];
