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
      'name': 'أحمد الفرعوني',
      'era': 'فرعوني',
      'tagline': 'محارب الصحراء الأسطوري',
      'description':
          'محارب شجاع من العصر الفرعوني، يتميز بقوته الخارقة وحكمته في المعارك. قاد العديد من الحملات العسكرية الناجحة وحمى أرض مصر من الغزاة. يحمل سيف الآلهة المقدس ويستطيع استدعاء قوة الشمس في المعارك.',
      'imageUrl':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop&crop=face',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'فاطمة الحكيمة',
      'era': 'فرعوني',
      'tagline': 'ساحرة المعابد المقدسة',
      'description':
          'كاهنة عظيمة تتقن فنون السحر القديم والشفاء. تحرس أسرار المعابد الفرعونية وتساعد المحاربين بقواها السحرية. تستطيع التحكم في عناصر الطبيعة واستدعاء الحماية الإلهية.',
      'imageUrl':
          'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=400&h=400&fit=crop&crop=face',
      'isLocked': false,
    },
    {
      'id': 3,
      'name': '؟؟؟',
      'era': 'مقفل — اكتشف في اللعب',
      'tagline': 'فارغ',
      'description': 'مقفل — العب اكتر علشان تفتحه',
      'imageUrl': '',
      'isLocked': true,
    },
    {
      'id': 4,
      'name': 'خالد الأسطورة',
      'era': 'فرعوني',
      'tagline': 'حامي الكنوز المفقودة',
      'description':
          'مستكشف ومغامر يبحث عن الكنوز المفقودة في الأهرامات والمعابد القديمة. يتميز بذكائه الحاد وقدرته على حل الألغاز المعقدة. يحمل خريطة سرية تقوده إلى أعظم الكنوز الفرعونية.',
      'imageUrl':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400&h=400&fit=crop&crop=face',
      'isLocked': false,
    },
  ];

  final List<Map<String, dynamic>> _battlesData = [
    {
      'id': 1,
      'name': 'قريباً',
      'era': 'المحتوى قيد التطوير',
      'tagline': 'معارك ملحمية قادمة قريباً',
      'description':
          'نحن نعمل على إضافة معارك مثيرة وتحديات ملحمية. ابق متابعاً للحصول على تحديثات حول المعارك القادمة والمغامرات الجديدة.',
      'imageUrl':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=400&fit=crop',
      'isLocked': false,
    },
  ];

  final List<Map<String, dynamic>> _achievementsData = [
    {
      'id': 1,
      'name': 'قريباً',
      'era': 'المحتوى قيد التطوير',
      'tagline': 'انجازات وجوائز قادمة قريباً',
      'description':
          'نحن نعمل على إضافة نظام انجازات شامل مع جوائز مثيرة ومكافآت خاصة. ستتمكن قريباً من جمع الانجازات وإفتخار بإنجازاتك في اللعبة.',
      'imageUrl':
          'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400&h=400&fit=crop',
      'isLocked': false,
    },
  ];

  final List<Map<String, dynamic>> _firstTimeData = [
    {
      'id': 1,
      'name': 'أول انتصار',
      'era': 'تجربة أولى',
      'tagline': 'لحظة النصر الأولى في اللعبة',
      'description':
          'تذكر دائماً لحظة انتصارك الأول في اللعبة. كانت معركة صعبة ضد أحد الحراس الفرعونيين، لكنك تمكنت من الفوز باستخدام استراتيجية ذكية وصبر طويل.',
      'imageUrl':
          'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400&h=400&fit=crop',
      'isLocked': false,
    },
    {
      'id': 2,
      'name': 'اكتشاف أول كنز',
      'era': 'تجربة أولى',
      'tagline': 'العثور على الكنز المخفي الأول',
      'description':
          'في أعماق الهرم الأكبر، عثرت على أول كنز حقيقي. كان صندوقاً ذهبياً يحتوي على جواهر نادرة وتعويذة سحرية قديمة زادت من قوتك بشكل كبير.',
      'imageUrl':
          'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=400&fit=crop',
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
    // Remove the lock check since all categories are now unlocked
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
            // Top curved header with dark teal background
            CurvedHeaderWidget(onHomeTap: _onHomeTap),

            // Main content area in light background
            Expanded(
              child: Container(
                width: double.infinity,
                color: const Color(0xFFe5c687), // Light beige/gold background
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
                                      color: const Color(
                                          0xFF264653), // Dark teal background for cards
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

            // Bottom curved section with category buttons
            Container(
              height: 20.h,
              child: Stack(
                children: [
                  // Curved background with dark teal color
                  ClipPath(
                    clipper: CurvedBottomClipper(),
                    child: Container(
                      height: 20.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF264653), // Dark teal background
                      ),
                    ),
                  ),
                  // Category buttons content
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

    // Start from top left with curve
    path.moveTo(0, 40);

    // Create curved top
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

    // Complete the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
