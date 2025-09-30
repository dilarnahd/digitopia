import 'package:flutter/material.dart'; 
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../services/supabase_service.dart';
import '../onboarding_video_screen/onboarding_video_screen.dart'; // Import your onboarding video screen

class PlayerInfoCollectionScreen extends StatefulWidget {
  const PlayerInfoCollectionScreen({super.key});

  @override
  State<PlayerInfoCollectionScreen> createState() =>
      _PlayerInfoCollectionScreenState();
}

class _PlayerInfoCollectionScreenState extends State<PlayerInfoCollectionScreen>
    with TickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();

  String? selectedAge;
  String? selectedLocation;
  String? selectedKnowledge;
  String? selectedIdentity;
  String? selectedInterest;
  String? selectedLearning;
  String? selectedGaming;
  String? selectedHistorical;

  final List<Map<String, dynamic>> egyptianQuestions = [
    {
      'question': 'اسمك ايه؟',
      'type': 'text',
      'field': 'name',
    },
    {
      'question': 'عندك كام سنة؟',
      'type': 'dropdown',
      'options': ['١٠–١٣', '١٤–١٦', '١٧–١٩', '٢٠+'],
      'field': 'age',
    },
    {
      'question': 'ساكن فين في مصر؟',
      'type': 'dropdown',
      'options': [
        'القاهرة',
        'اسكندرية',
        'الصعيد',
        'الدلتا',
        'القنال',
        'سينا',
        'مناطق تانية'
      ],
      'field': 'location',
    },
    {
      'question': 'بتعرف قد ايه عن تاريخ مصر؟',
      'type': 'options',
      'options': [
        'قليل اوي (محتاج اتعلم)',
        'متوسط (عارف شوية)',
        'جامد (فاكر نفسي مؤرخ)'
      ],
      'field': 'knowledge',
    },
    {
      'question': 'حاسس انك فاهم هويتك المصرية قد ايه؟',
      'type': 'options',
      'options': ['مش قوي', 'نص نص', 'فخور ومبسوط بيها'],
      'field': 'identity',
    },
    {
      'question': 'ايه اكتر حاجة بتحبها؟',
      'type': 'options',
      'options': ['رياضة', 'موسيقى', 'افلام', 'جيمز', 'قراءة', 'تكنولوجيا'],
      'field': 'interest',
    },
    {
      'question': 'بتحب تتعلم/تلعب ازاي؟',
      'type': 'options',
      'options': ['قصص', 'مسابقات', 'قراءة', 'لعب عملي'],
      'field': 'learning',
    },
    {
      'question': 'بتلعب جيمز قد ايه؟',
      'type': 'options',
      'options': ['كل يوم', 'كل فترة', 'نادر'],
      'field': 'gaming',
    },
    {
      'question': 'لو معاك آلة زمن تروح انهي فترة؟',
      'type': 'options',
      'options': ['الفرعوني', 'الاسلامي', 'الحديث', 'دلوقتي'],
      'field': 'historical',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedData() async {
    try {
      final playerInfo = await SupabaseService.instance.getPlayerInfo();
      if (playerInfo != null && mounted) {
        setState(() {
          _nameController.text = playerInfo['player_name'] ?? '';
          selectedAge = playerInfo['player_age']?.toString();
          selectedLocation = playerInfo['player_location'] ?? '';
          selectedKnowledge = playerInfo['egypt_knowledge_level'] ?? '';
          selectedIdentity = playerInfo['egyptian_identity_feeling'] ?? '';
          selectedInterest = playerInfo['favorite_activity'] ?? '';
          selectedLearning = playerInfo['learning_preference'] ?? '';
          selectedGaming = playerInfo['gaming_frequency'] ?? '';
          selectedHistorical = playerInfo['historical_period_preference'] ?? '';
        });
      }
    } catch (e) {
      // Silent fail
    }
  }

  double get _progressPercentage {
    int answered = 0;
    if (_nameController.text.trim().isNotEmpty) answered++;
    if (selectedAge != null) answered++;
    if (selectedLocation != null) answered++;
    if (selectedKnowledge != null) answered++;
    if (selectedIdentity != null) answered++;
    if (selectedInterest != null) answered++;
    if (selectedLearning != null) answered++;
    if (selectedGaming != null) answered++;
    if (selectedHistorical != null) answered++;
    return answered / egyptianQuestions.length;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF264653),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5C687),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'عرفنا عليك',
                          style: GoogleFonts.inter(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF264653),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          width: double.infinity,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(76),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: LinearProgressIndicator(
                            value: _progressPercentage,
                            backgroundColor: Colors.transparent,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF264653),
                            ),
                            minHeight: 8,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          '${(_progressPercentage * 100).round()}% مكتملة',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: const Color(0xFF264653),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        ...egyptianQuestions.asMap().entries.map((entry) {
                          final index = entry.key;
                          final question = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 3.h),
                            child: _buildQuestionWidget(question, index),
                          );
                        }).toList(),
                        SizedBox(height: 3.h),
                        SizedBox(
                          width: double.infinity,
                          height: 6.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const OnboardingVideoScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF264653),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: Text(
                              'متابعة إلى الفيديو',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(Map<String, dynamic> question, int index) {
    final questionText = question['question'] as String;
    final type = question['type'] as String;
    final field = question['field'] as String;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: Text(
            '${index + 1}. $questionText',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF264653),
            ),
            textAlign: TextAlign.right,
          ),
        ),
        if (type == 'text') _buildTextInput(),
        if (type == 'dropdown')
          _buildDropdownInput(field, question['options'] as List<String>),
        if (type == 'options')
          _buildOptionsInput(field, question['options'] as List<String>),
      ],
    );
  }

  Widget _buildTextInput() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF264653).withAlpha(51),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _nameController,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: GoogleFonts.inter(
          fontSize: 15.sp,
          color: const Color(0xFF264653),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'اكتب اسمك هنا...',
          hintStyle: GoogleFonts.inter(
            color: Colors.grey.shade500,
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildDropdownInput(String field, List<String> options) {
    String? currentValue;
    switch (field) {
      case 'age':
        currentValue = selectedAge;
        break;
      case 'location':
        currentValue = selectedLocation;
        break;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF264653).withAlpha(51),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          hint: Text(
            'اختار من القائمة...',
            style: GoogleFonts.inter(
              color: Colors.grey.shade500,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          isExpanded: true,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            color: const Color(0xFF264653),
            fontWeight: FontWeight.w500,
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                option,
                textDirection: TextDirection.rtl,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              if (field == 'age') selectedAge = newValue;
              if (field == 'location') selectedLocation = newValue;
            });
          },
        ),
      ),
    );
  }

  Widget _buildOptionsInput(String field, List<String> options) {
    String? currentValue;
    switch (field) {
      case 'knowledge':
        currentValue = selectedKnowledge;
        break;
      case 'identity':
        currentValue = selectedIdentity;
        break;
      case 'interest':
        currentValue = selectedInterest;
        break;
      case 'learning':
        currentValue = selectedLearning;
        break;
      case 'gaming':
        currentValue = selectedGaming;
        break;
      case 'historical':
        currentValue = selectedHistorical;
        break;
    }

    return Column(
      children: options.map((option) {
        final isSelected = currentValue == option;
        return Padding(
          padding: EdgeInsets.only(bottom: 1.h),
          child: GestureDetector(
            onTap: () {
              setState(() {
                switch (field) {
                  case 'knowledge':
                    selectedKnowledge = option;
                    break;
                  case 'identity':
                    selectedIdentity = option;
                    break;
                  case 'interest':
                    selectedInterest = option;
                    break;
                  case 'learning':
                    selectedLearning = option;
                    break;
                  case 'gaming':
                    selectedGaming = option;
                    break;
                  case 'historical':
                    selectedHistorical = option;
                    break;
                }
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF264653) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF264653)
                      : const Color(0xFF264653).withAlpha(51),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(13),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                option,
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  color: isSelected ? Colors.white : const Color(0xFF264653),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
