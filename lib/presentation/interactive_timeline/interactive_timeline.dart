


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

  // Mock historical eras data in Egyptian Arabic slang
  final List<Map<String, dynamic>> _historicalEras = [
    {
      "id": 1,
      "title": "أيام الجاهلية",
      "period": "قبل الإسلام - 622 م",
      "description":
          "دي الأيام اللي كانت قبل الإسلام في جزيرة العرب، كان وقت الشعر والقبائل والتجارة",
      "keyEvents": ["سوق عكاظ", "حرب البسوس", "حلف الفضول"],
      "color": "#264653",
    },
    {
      "id": 2,
      "title": "عصر الرسالة",
      "period": "622 - 632 م",
      "description":
          "هنا بدأ الإسلام ونزل القرآن على سيدنا محمد صلى الله عليه وسلم",
      "keyEvents": ["هجرة النبي", "غزوة بدر", "فتح مكة"],
      "color": "#264653",
    },
    {
      "id": 3,
      "title": "الخلفا الراشدين",
      "period": "632 - 661 م",
      "description":
          "دي فترة الخلفا الأربعة الراشدين ولما توسعت الدولة الإسلامية",
      "keyEvents": ["خلافة أبو بكر", "الفتوحات الإسلامية", "جمع القرآن"],
      "color": "#264653",
    },
    {
      "id": 4,
      "title": "الدولة الأموية",
      "period": "661 - 750 م",
      "description": "الأمويين نقلوا العاصمة لدمشق والإمبراطورية بقت أكبر",
      "keyEvents": ["معاوية بن أبي سفيان", "فتح الأندلس", "قبة الصخرة"],
      "color": "#264653",
    },
    {
      "id": 5,
      "title": "العصر العباسي",
      "period": "750 - 1258 م",
      "description": "دي الأيام الحلوة للحضارة الإسلامية وبغداد بقت العاصمة",
      "keyEvents": ["بيت الحكمة", "هارون الرشيد", "ترجمة العلوم"],
      "color": "#264653",
    },
    {
      "id": 6,
      "title": "الدول المستقلة",
      "period": "900 - 1500 م",
      "description": "طلعت دول مستقلة في أماكن مختلفة في العالم الإسلامي",
      "keyEvents": ["الدولة الفاطمية", "الدولة الأيوبية", "المماليك"],
      "color": "#264653",
    },
    {
      "id": 7,
      "title": "العثمانليين",
      "period": "1299 - 1922 م",
      "description": "الإمبراطورية العثمانية وحدت معظم العالم الإسلامي",
      "keyEvents": ["فتح القسطنطينية", "سليمان القانوني", "الخلافة العثمانية"],
      "color": "#264653",
    },
    {
      "id": 8,
      "title": "العصر الجديد",
      "period": "1800 - دلوقتي",
      "description": "النهضة العربية الاستقلال وإنشاء الدول الحديثة",
      "keyEvents": ["النهضة العربية", "الاستقلال", "جامعة الدول العربية"],
      "color": "#264653",
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Handle pull-to-refresh functionality
  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate content refresh
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isRefreshing = false;
    });

    // Show refresh feedback
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

  /// Handle timeline block navigation
  void _handleBlockNavigation(Map<String, dynamic> eraData) {
    // Haptic feedback for iOS
    HapticFeedback.lightImpact();

    // Show era details in bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildEraDetailsSheet(eraData),
    );
  }

  /// Build era details bottom sheet
  Widget _buildEraDetailsSheet(Map<String, dynamic> eraData) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.darkTheme.colorScheme.surface
            : AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 1.h),
            width: 12.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: isDark
                  ? AppTheme.textSecondaryDark
                  : AppTheme.textSecondaryLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Title
                  Text(
                    (eraData['title'] as String?) ?? '',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    textDirection: TextDirection.rtl,
                  ),

                  SizedBox(height: 1.h),

                  // Period
                  Text(
                    (eraData['period'] as String?) ?? '',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDark
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondaryLight,
                      fontSize: 16.sp,
                    ),
                    textDirection: TextDirection.rtl,
                  ),

                  SizedBox(height: 3.h),

                  // Description
                  Text(
                    (eraData['description'] as String?) ?? '',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontSize: 16.sp,
                      height: 1.6,
                    ),
                    textDirection: TextDirection.rtl,
                  ),

                  SizedBox(height: 3.h),

                  // Key events
                  Text(
                    'الأحداث الرئيسية:',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),

                  SizedBox(height: 2.h),

                  // Events list
                  Expanded(
                    child: ListView.builder(
                      itemCount: ((eraData['keyEvents'] as List?)?.length ?? 0),
                      itemBuilder: (context, index) {
                        final event =
                            (eraData['keyEvents'] as List)[index] as String;
                        return Container(
                          margin: EdgeInsets.only(bottom: 1.h),
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: (isDark
                                    ? AppTheme
                                        .darkTheme.colorScheme.primaryContainer
                                    : AppTheme.lightTheme.colorScheme.primary)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  event,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              CustomIconWidget(
                                iconName: 'circle',
                                color:
                                    AppTheme.lightTheme.colorScheme.secondary,
                                size: 8,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Close button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'إغلاق',
                        style: TextStyle(fontSize: 16.sp),
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFe5c687),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: const Color(0xFF264653),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Curved header
              SliverToBoxAdapter(
                child: CurvedHeaderWidget(
                  title: 'اكتشف رحلتك عبر التاريخ',
                  subtitle:
                      'هنا هتلاقي كل العصور اللي ممكن تلعبها في اللعبة، انت ممكن تلعب من الاول للاخر او عصر انت تختاره',
                  onBackPressed: () => Navigator.of(context).pop(),
                ),
              ),

              // Timeline content
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Stack(
                    children: [
                      // Central continuous line
                      Positioned(
                        left: 50.w - 2,
                        top: 0,
                        child: TimelineConnectorWidget(
                          height: (_historicalEras.length * 20.h) + 10.h,
                        ),
                      ),

                      // Timeline blocks
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

              // Bottom spacing
              SliverToBoxAdapter(child: SizedBox(height: 5.h)),
            ],
          ),
        ),
      ),
    );
  }
}
