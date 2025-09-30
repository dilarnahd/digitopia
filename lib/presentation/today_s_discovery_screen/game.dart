import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../widgets/custom_icon_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<Map<String, String>> _glyphs = [
    {
      "file": "assets/glyphs/life_glyph.svg",
      "name": "Life",
      "pronunciation": "Ankh"
    },
    {
      "file": "assets/glyphs/djed_stability_glyph.svg",
      "name": "Stability",
      "pronunciation": "Djed"
    },
  ];

  void _showGlyphMeaning(String name, String pronunciation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(name),
        content: Text("Pronunciation: $pronunciation"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFE5C687),
        body: SafeArea(
          child: Stack(
            children: [
              SvgPicture.asset(
                "assets/glyphs/temple_background.svg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 5.h,
                left: 10.w,
                child: SvgPicture.asset(
                  "assets/glyphs/character.svg",
                  width: 20.w,
                  height: 30.h,
                ),
              ),
              ..._glyphs.asMap().entries.map(
                (entry) {
                  int index = entry.key;
                  Map<String, String> glyph = entry.value;
                  double leftPos = 25.w + index * 20.w;
                  double topPos = 15.h;

                  return Positioned(
                    left: leftPos,
                    top: topPos,
                    child: GestureDetector(
                      onTap: () =>
                          _showGlyphMeaning(glyph['name']!, glyph['pronunciation']!),
                      child: SvgPicture.asset(
                        glyph['file']!,
                        width: 10.w,
                        height: 10.w,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                top: 2.h,
                left: 4.w,
                child: GestureDetector(
                  onTap: _onBackPressed,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: CustomIconWidget(
                        iconName: 'arrow_back',
                        color: Color(0xFFD4AF37),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
