import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/category_button_widget.dart';
import './widgets/character_card_widget.dart';
import './widgets/curved_header_widget.dart';
import './widgets/shimmer_loading_widget.dart';

class DictLibraryScreen extends StatefulWidget {
  const DictLibraryScreen({Key? key}) : super(key: key);

  @override
  State<DictLibraryScreen> createState() => _DictLibraryScreenState();
}

class _DictLibraryScreenState extends State<DictLibraryScreen> {
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
      'imageAsset': 'assets/images/Ramses_II_British_Museum.svg',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'كليوباترا السابعة',
      'era': 'بطلمي',
      'tagline': 'ملكة مصر الأخيرة',
      'description':
          'الملكة الشهيرة التي حكمت مصر البِتْلمية، اشتهرت بذكائها السياسي وعلاقاتها مع روما، وحاولت حماية مصر من النفوذ الروماني.',
      'imageAsset': 'assets/images/Kleopatra-VII.-Altes-Museum-Berlin1.svg',
      'isLocked': false,
    },
    {
      'id': 3,
      'name': 'جمال عبد الناصر',
      'era': 'معاصر',
      'tagline': 'رئيس مصر ورمز الوحدة العربية',
      'description':
          'رئيس مصر بين 1956 و1970، قاد ثورة 1952، وحقق مشاريع ضخمة مثل بناء السد العالي وتعزيز الوحدة العربية.',
      'imageAsset': 'assets/images/Gamal_Abdel_Naser_u_Beogradu,_1962 (1).svg',
      'isLocked': false,
    },
    {
      'id': 4,
      'name': 'حسين هيكل',
      'era': 'معاصر',
      'tagline': 'رائد الصحافة المصرية',
      'description':
          'كاتب وصحفي مصري معروف، ساهم في تطوير الإعلام المصري والكتابة السياسية والاجتماعية في القرن العشرين.',
      'imageAsset': 'assets/images/hussein_hekl.svg',
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
      'imageAsset': 'assets/images/King_Narmer.svg',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'ثورة 1919',
      'era': 'حديث',
      'tagline': 'الانتفاضة الوطنية ضد الاحتلال البريطاني',
      'description':
          'انتفاضة شعبية مصرية قادها سعد زغلول ضد الاحتلال البريطاني، وأسهمت في إحياء الروح الوطنية والمطالبة بالاستقلال.',
      'imageAsset': 'assets/images/Cairo_From_Tower_(cropped).svg',
      'isLocked': false,
    },
    {
      'id': 3,
      'name': 'حرب أكتوبر 1973',
      'era': 'حديث',
      'tagline': 'استرداد الأراضي المحتلة',
      'description':
          'حرب بين مصر وسوريا ضد إسرائيل لاستعادة الأراضي المحتلة، أظهرت الشجاعة المصرية والتخطيط العسكري المحترف.',
      'imageAsset': 'assets/images/high_dam.svg',
      'isLocked': false,
    },
    {
      'id': 4,
      'name': 'معركة عين جالوت',
      'era': 'إسلامي',
      'tagline': 'تصدي المماليك للغزو المغولي',
      'description':
          'انتصار المماليك على المغول في فلسطين، والذي ساهم في حماية مصر والشام من الغزو المغولي.',
      'imageAsset': 'assets/images/Campaign_of_the_Battle_of_Ain_Jalut_1260.svg.svg',
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
      'imageAsset': 'assets/images/Great_Pyramid_of_Giza_-_Pyramid_of_Khufu.svg',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'تأميم قناة السويس',
      'era': 'حديث',
      'tagline': 'خطوة نحو السيادة الوطنية',
      'description':
          'في 1956، قام جمال عبد الناصر بتأميم قناة السويس، مما أعاد لمصر السيطرة على طريق مائي حيوي ومصدر دخل رئيسي.',
      'imageAsset': 'assets/images/suez_canal.svg',
      'isLocked': false,
    },
    {
      'id': 3,
      'name': 'إنشاء السد العالي',
      'era': 'حديث',
      'tagline': 'مشروع النهضة المصرية',
      'description':
          'السد العالي في أسوان الذي بنته الحكومة المصرية لتوفير المياه وتحسين الزراعة وتوليد الكهرباء.',
      'imageAsset': 'assets/images/electricity.svg',
      'isLocked': false,
    },
    {
      'id': 4,
      'name': 'تطوير القاهرة الحديثة',
      'era': 'حديث',
      'tagline': 'نهضة عمرانية وثقافية',
      'description':
          'توسيع وتحديث القاهرة خلال القرن العشرين لتعزيز التعليم والثقافة والبنية التحتية.',
      'imageAsset': 'assets/images/Cairo_University_Crest.svg',
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
      'imageAsset': 'assets/images/King_Narmer.svg',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'أول استخدام للورق البردي',
      'era': 'فرعوني',
      'tagline': 'اختراع الكتابة والورق',
      'description':
          'ابتكر المصريون القدماء استخدام البردي لتسجيل المعلومات والوثائق، مما ساهم في حفظ التاريخ والمعرفة.',
      'imageAsset': 'assets/images/papyrus.svg',
      'isLocked': false,
    },
    {
      'id': 3,
      'name': 'أول محطة كهرباء في مصر',
      'era': 'حديث',
      'tagline': 'بداية الكهرباء في مصر',
      'description':
          'تم إنشاء أول محطة كهرباء في مصر لتوفير الطاقة للمصانع والمنازل، وبدأ عصر الحداثة.',
      'imageAsset': 'assets/images/electricity.svg',
      'isLocked': false,
    },
    {
      'id': 4,
      'name': 'أول جامعة مصرية حديثة',
      'era': 'حديث',
      'tagline': 'التعليم العالي المنظم',
      'description':
          'جامعة فؤاد الأول (جامعة القاهرة الآن) هي أول جامعة حديثة في مصر، أسست لتطوير التعليم العالي والبحث العلمي.',
      'imageAsset': 'assets/images/Cairo_University_Crest.svg',
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
        backgroundColor: const Color(0xFFe5c687),
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
                                          .withOpacity(0.7),
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
                                            .withOpacity(0.8),
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
                                  final character =
                                      _getCurrentCategoryData()[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 2.h),
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF264653),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          character['imageAsset'],
                                          width: double.infinity,
                                          height: 150,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(height: 2.h),
                                        CharacterCardWidget(
                                          character: character,
                                        ),
                                      ],
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
