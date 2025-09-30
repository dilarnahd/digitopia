import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_button_widget.dart';
import './widgets/character_card_widget.dart';
import './widgets/curved_header_widget.dart';
import './widgets/shimmer_loading_widget.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedCategoryIndex = 0;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _categories = [
    {'title': 'شخصيات', 'isLocked': false},
    {'title': 'معارك', 'isLocked': false},
    {'title': 'انجازات', 'isLocked': false},
    {'title': 'أول-مرة', 'isLocked': false},
  ];

  final List<Map<String, dynamic>> _charactersData = [
    {
      'id': 1,
      'name': 'رمسيس الثاني',
      'era': 'فرعوني',
      'tagline': 'فرعون الحروب والمعمار',
      'description':
          'فرعون مشهور من الأسرة التاسعة عشر، قاد مصر في العديد من الحروب وترك إرثاً عظيماً من المعابد والتماثيل.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/1/1d/Ramses_II.jpg',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'كليوباترا السابعة',
      'era': 'بطلمي',
      'tagline': 'ملكة مصر الأخيرة',
      'description':
          'الملكة الشهيرة التي حكمت مصر البِتْلمية، اشتهرت بذكائها السياسي وعلاقاتها مع روما، وحاولت حماية مصر من النفوذ الروماني.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/2/2e/Cleopatra_VII_of_Egypt_Altes_Museum_Berlin.jpg',
      'isLocked': false,
    },
    {
      'id': 3,
      'name': 'جمال عبد الناصر',
      'era': 'معاصر',
      'tagline': 'رئيس مصر ورمز الوحدة العربية',
      'description':
          'رئيس مصر بين 1956 و1970، قاد ثورة 1952، وحقق مشاريع ضخمة مثل بناء السد العالي وتعزيز الوحدة العربية.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/4/44/Gamal_Abdel_Nasser.jpg',
      'isLocked': false,
    },
    {
      'id': 4,
      'name': 'حسين هيكل',
      'era': 'معاصر',
      'tagline': 'رائد الصحافة المصرية',
      'description':
          'كاتب وصحفي مصري معروف، ساهم في تطوير الإعلام المصري والكتابة السياسية والاجتماعية في القرن العشرين.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/a/a3/Hussein_Hekal.jpg',
      'isLocked': false,
    },
  ];

  final List<Map<String, dynamic>> _battlesData = [
    {
      'id': 1,
      'name': 'معركة قادش',
      'era': 'فرعوني',
      'tagline': 'أكبر معركة بحرية وعسكرية في العصر القديم',
      'description':
          'خاض رمسيس الثاني معركة قادش ضد الحيثيين في سوريا، وتميزت باستخدام العربات الحربية بشكل استراتيجي.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/7/7a/Battle_of_Kadesh_relief.jpg',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'ثورة 1919',
      'era': 'حديث',
      'tagline': 'الانتفاضة الوطنية ضد الاحتلال البريطاني',
      'description':
          'انتفاضة شعبية مصرية قادها سعد زغلول ضد الاحتلال البريطاني، وأسهمت في إحياء الروح الوطنية والمطالبة بالاستقلال.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/2/25/Egyptian_1919_revolution.jpg',
      'isLocked': false,
    },
    {
      'id': 3,
      'name': 'حرب أكتوبر 1973',
      'era': 'حديث',
      'tagline': 'استرداد الأراضي المحتلة',
      'description':
          'حرب بين مصر وسوريا ضد إسرائيل لاستعادة الأراضي المحتلة، أظهرت الشجاعة المصرية والتخطيط العسكري المحترف.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/5/5c/Yom_Kippur_War_1973.jpg',
      'isLocked': false,
    },
    {
      'id': 4,
      'name': 'معركة عين جالوت',
      'era': 'إسلامي',
      'tagline': 'تصدي المماليك للغزو المغولي',
      'description':
          'انتصار المماليك على المغول في فلسطين، والذي ساهم في حماية مصر والشام من الغزو المغولي.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/f/f5/Battle_of_Ain_Jalut.jpg',
      'isLocked': false,
    },
  ];

  final List<Map<String, dynamic>> _achievementsData = [
    {
      'id': 1,
      'name': 'بناء الهرم الأكبر',
      'era': 'فرعوني',
      'tagline': 'أعجوبة معمارية عالمية',
      'description':
          'تم بناء هرم خوفو في الجيزة ليكون مقبرة فرعونية ضخمة، ويعتبر من عجائب العالم القديم.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/e/e3/Great_Pyramid_of_Giza.jpg',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'تأميم قناة السويس',
      'era': 'حديث',
      'tagline': 'خطوة نحو السيادة الوطنية',
      'description':
          'في 1956، قام جمال عبد الناصر بتأميم قناة السويس، مما أعاد لمصر السيطرة على طريق مائي حيوي ومصدر دخل رئيسي.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/1/17/Suez_Canal_Nationalization.jpg',
      'isLocked': false,
    },
    {
      'id': 3,
      'name': 'إنشاء السد العالي',
      'era': 'حديث',
      'tagline': 'مشروع النهضة المصرية',
      'description':
          'السد العالي في أسوان الذي بنته الحكومة المصرية لتوفير المياه وتحسين الزراعة وتوليد الكهرباء.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/9/95/Aswan_High_Dam.jpg',
      'isLocked': false,
    },
    {
      'id': 4,
      'name': 'تطوير القاهرة الحديثة',
      'era': 'حديث',
      'tagline': 'نهضة عمرانية وثقافية',
      'description':
          'توسيع وتحديث القاهرة خلال القرن العشرين لتعزيز التعليم والثقافة والبنية التحتية.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/d/d1/Cairo_modern.jpg',
      'isLocked': false,
    },
  ];

  final List<Map<String, dynamic>> _firstTimeData = [
    {
      'id': 1,
      'name': 'أول فرعون موثق',
      'era': 'فرعوني',
      'tagline': 'توثيق أول حكم فرعوني',
      'description':
          'نارمر أو مينا هو أول فرعون موثق وحد مصر العليا والسفلى، ويعتبر بداية الدولة المصرية القديمة.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/5/54/Narmer_Palette.jpg',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'أول استخدام للورق البردي',
      'era': 'فرعوني',
      'tagline': 'اختراع الكتابة والورق',
      'description':
          'ابتكر المصريون القدماء استخدام البردي لتسجيل المعلومات والوثائق، مما ساهم في حفظ التاريخ والمعرفة.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/3/32/Papyrus_roll.jpg',
      'isLocked': false,
    },
    {
      'id': 3,
      'name': 'أول محطة كهرباء في مصر',
      'era': 'حديث',
      'tagline': 'بداية الكهرباء في مصر',
      'description':
          'تم إنشاء أول محطة كهرباء في مصر لتوفير الطاقة للمصانع والمنازل، وبدأ عصر الحداثة.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/6/66/Cairo_electric_plant.jpg',
      'isLocked': false,
    },
    {
      'id': 4,
      'name': 'أول جامعة مصرية حديثة',
      'era': 'حديث',
      'tagline': 'التعليم العالي المنظم',
      'description':
          'جامعة فؤاد الأول (جامعة القاهرة الآن) هي أول جامعة حديثة في مصر، أسست لتطوير التعليم العالي والبحث العلمي.',
      'imageUrl':
          'https://upload.wikimedia.org/wikipedia/commons/0/0f/Cairo_University_1908.jpg',
      'isLocked': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading time
    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      _isLoading = false;
    });
  }

  void _onCategoryTap(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
    _loadContent();
  }

  List<Map<String, dynamic>> _getCurrentCategoryData() {
    switch (_selectedCategoryIndex) {
      case 0:
        return _charactersData;
      case 1:
        return _battlesData;
      case 2:
        return _achievementsData;
      case 3:
        return _firstTimeData;
      default:
        return _charactersData;
    }
  }

  void _onProfileTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'الملف الشخصي قريباً!',
          textAlign: TextAlign.right,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _onSettingsTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'الإعدادات قريباً!',
          textAlign: TextAlign.right,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onPrimary,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _onHomeTap() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFe5c687), // Light beige/gold background
        body: Column(
          children: [
            CurvedHeaderWidget(onHomeTap: _onHomeTap),

            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFe5c687),
                child: _isLoading
                    ? const ShimmerLoadingWidget()
                    : RefreshIndicator(
                        onRefresh: _loadContent,
                        color: const Color(0xFF264653),
                        child: _getCurrentCategoryData().isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'inbox',
                                      color: const Color(0xFF264653)
                                          .withValues(alpha: 0.7),
                                      size: 48,
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      'لا يوجد محتوى متاح حالياً',
                                      textAlign: TextAlign.right,
                                      style: AppTheme
                                          .lightTheme.textTheme.bodyLarge
                                          ?.copyWith(
                                        color: const Color(0xFF264653)
                                            .withValues(alpha: 0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 2.h),
                                itemCount: _getCurrentCategoryData().length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 2.h),
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF264653),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: CharacterCardWidget(
                                      character:
                                          _getCurrentCategoryData()[index],
                                    ),
                                  );
                                },
                              ),
                      ),
              ),
            ),

            Container(
              height: 20.h,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: CurvedBottomClipper(),
                    child: Container(
                      height: 20.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF264653),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          _categories.length,
                          (index) => CategoryButtonWidget(
                            title: _categories[index]['title'],
                            isSelected: _selectedCategoryIndex == index,
                            isLocked: false,
                            onTap: () => _onCategoryTap(index),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 40);

    var firstControlPoint = Offset(size.width * 0.25, 0);
    var firstEndPoint = Offset(size.width * 0.5, 20);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint = Offset(size.width * 0.75, 40);
    var secondEndPoint = Offset(size.width, 20);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

