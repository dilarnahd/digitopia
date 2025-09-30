import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/curved_header_widget.dart';
import './widgets/timeline_block_widget.dart';
import './widgets/timeline_connector_widget.dart';

/// Interactive Timeline Screen
/// Main educational interface for exploring historical eras through touch-optimized Arabic content
class InteractiveTimeline extends StatefulWidget {
  const InteractiveTimeline({super.key});

  @override
  State<InteractiveTimeline> createState() => _InteractiveTimelineState();
}

class _InteractiveTimelineState extends State<InteractiveTimeline> {
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  // Mock historical eras focused on Egypt
  final List<Map<String, dynamic>> _historicalEras = [
    {
      "id": 1,
      "title": "عصر ما قبل الأسرات",
      "period": "5000 - 3100 ق.م",
      "description":
          "العصور اللي قبل توحيد مصر، ظهور القرى الأولى والزراعة على ضفاف النيل",
      "keyEvents": ["الاستيطان على النيل", "تطور الفخار", "الكتابة المبكرة"],
      "color": "#264653",
    },
    {
      "id": 2,
      "title": "العصر الفرعوني المبكر",
      "period": "3100 - 2686 ق.م",
      "description":
          "توحيد مصر العليا والسفلى وبدء الأسرات الأولى، ظهور الأهرامات الأولى",
      "keyEvents": ["توحيد مصر", "أول ملوك مصر", "بناء المقابر الأولى"],
      "color": "#264653",
    },
    {
      "id": 3,
      "title": "العصر القديم",
      "period": "2686 - 2181 ق.م",
      "description":
          "عصر بناء الأهرامات والمعابد، ازدهار الدولة القديمة وقوة الفراعنة",
      "keyEvents": ["بناء الهرم الأكبر", "الهرم الزقزاقي", "تطوير النقوش الهيروغليفية"],
      "color": "#264653",
    },
    {
      "id": 4,
      "title": "العصر الوسيط",
      "period": "2055 - 1650 ق.م",
      "description":
          "فترة استقرار وازدهار بعد انهيار الدولة القديمة، مع تطوير الفنون والكتابة",
      "keyEvents": ["بناء المعابد", "الفن الأدبي", "التحكم في النيل"],
      "color": "#264653",
    },
    {
      "id": 5,
      "title": "العصر الحديث",
      "period": "1550 - 1070 ق.م",
      "description":
          "أشهر الفراعنة مثل تحتمس الثالث ورمسيس الثاني، توسع الإمبراطورية المصرية",
      "keyEvents": ["الفتح العسكري", "بناء المعابد الكبرى", "الكتابة الهيروغليفية"],
      "color": "#264653",
    },
    {
      "id": 6,
      "title": "العصر المتأخر",
      "period": "664 - 332 ق.م",
      "description":
          "انحدار الدولة المصرية القديمة وظهور الاحتلالات الأجنبية مثل الفرس",
      "keyEvents": ["حكم الفرس", "الثقافة والفن المتأخر", "المعارك الداخلية"],
      "color": "#264653",
    },
    {
      "id": 7,
      "title": "العصر البطلمي",
      "period": "332 - 30 ق.م",
      "description":
          "حكم الإسكندر الأكبر ثم البطالمة، روعة فنون الهيلينستيك في مصر",
      "keyEvents": ["الإسكندر الأكبر", "حكم البطالمة", "مكتبة الإسكندرية"],
      "color": "#264653",
    },
    {
      "id": 8,
      "title": "العصر الروماني والقبطي",
      "period": "30 ق.م - 641 م",
      "description":
          "سيطرة الرومان ثم ظهور المسيحية، بداية العصر القبطي في مصر",
      "keyEvents": ["الحكم الروماني", "انتشار المسيحية", "الفن القبطي"],
      "color": "#264653",
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Pull-to-refresh
  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isRefreshing = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم تحديث المحتوى',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 14.sp),
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  /// Handle block navigation
  void _handleBlockNavigation(Map<String, dynamic> eraData) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEraDetailsSheet(eraData),
    );
  }

  /// Bottom sheet
  Widget _buildEraDetailsSheet(Map<String, dynamic> eraData) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE5C678),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 1.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: const Color(0xFF264653),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    eraData['title'] ?? '',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF264653),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    eraData['period'] ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF264653),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    eraData['description'] ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      height: 1.6,
                      color: const Color(0xFF264653),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    'الأحداث الرئيسية:',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF264653),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: (eraData['keyEvents'] as List?)?.length ?? 0,
                      itemBuilder: (context, index) {
                        final event = (eraData['keyEvents'] as List)[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 1.h),
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF264653).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  event,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF264653),
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              CustomIconWidget(
                                iconName: 'circle',
                                color: const Color(0xFF264653),
                                size: 8,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF264653),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'إغلاق',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFFE5C678),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE5C678),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: const Color(0xFF264653),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: CurvedHeaderWidget(
                  title: 'اكتشف رحلتك عبر التاريخ',
                  subtitle:
                      'هنا هتلاقي كل العصور اللي ممكن تلعبها في اللعبة، انت ممكن تلعب من الاول للاخر او عصر انت تختاره',
                  onBackPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 50.w - 2,
                        top: 0,
                        child: TimelineConnectorWidget(
                          height: (_historicalEras.length * 20.h) + 10.h,
                        ),
                      ),
                      Column(
                        children: _historicalEras.asMap().entries.map((entry) {
                          final index = entry.key;
                          final era = entry.value;
                          final isLeftAligned = index % 2 == 0;
                          return TimelineBlockWidget(
                            eraData: era,
                            isLeftAligned: isLeftAligned,
                            onGoPressed: () => _handleBlockNavigation(era),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 5.h)),
            ],
          ),
        ),
      ),
    );
  }
}
