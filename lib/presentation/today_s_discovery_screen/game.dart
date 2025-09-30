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
      "pronunciation": "Ankh",
      "description":
          "The Ankh is an ancient Egyptian hieroglyphic symbol meaning 'life'. It represents eternal life and was often carried by gods and pharaohs."
    },
    {
      "file": "assets/glyphs/djed_stability_glyph.svg",
      "name": "Stability",
      "pronunciation": "Djed",
      "description":
          "The Djed pillar represents stability and strength. It is often associated with Osiris and symbolizes enduring power and support."
    },
  ];

  void _showGlyphMeaning(String name, String pronunciation, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pronunciation: $pronunciation"),
            SizedBox(height: 1.h),
            Text(description),
          ],
        ),
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
    return Scaffold(
      backgroundColor: const Color(0xFFE5C687),
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Positioned.fill(
              child: SvgPicture.asset(
                "assets/glyphs/temple_background.svg",
                fit: BoxFit.cover,
              ),
            ),

            // Player character (2× bigger)
            Positioned(
              bottom: 2.h,
              left: 5.w,
              child: SvgPicture.asset(
                "assets/glyphs/character.svg",
                width: 50.w, // doubled width
                height: 70.h, // doubled height
              ),
            ),

            // Glyphs (bigger, lower, closer together, more left)
            ..._glyphs.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> glyph = entry.value;
              double leftPos = 10.w + index * 18.w; // closer together, more left
              double topPos = 28.h; // lower

              return Positioned(
                left: leftPos,
                top: topPos,
                child: GestureDetector(
                  onTap: () => _showGlyphMeaning(
                    glyph['name']!,
                    glyph['pronunciation']!,
                    glyph['description']!,
                  ),
                  child: SvgPicture.asset(
                    glyph['file']!,
                    width: 16.w, // bigger
                    height: 16.w,
                  ),
                ),
              );
            }).toList(),

            // Back button (left side)
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
    );
  }
}
