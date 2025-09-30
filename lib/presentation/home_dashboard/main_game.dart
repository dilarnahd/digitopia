import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainGame extends StatelessWidget {
  const MainGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double characterX = 0; // relative position (centered)
  final double step = 30; // step size
  final List<Offset> blockPositions = [
    const Offset(-100, 250),
    const Offset(0, 250),
    const Offset(100, 250),
  ];

  int? draggingIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background pyramid (SVG)
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/main_game/pyramid.svg",
              fit: BoxFit.cover,
            ),
          ),

          // Character (SVG)
          Positioned(
            bottom: 40,
            left: screenWidth / 2 + characterX - 40,
            child: SizedBox(
              width: 80,
              height: 80,
              child: SvgPicture.asset("assets/images/main_game/character.svg"),
            ),
          ),

          // Blocks (PNG instead of SVG)
          for (int i = 0; i < blockPositions.length; i++)
            Positioned(
              left: screenWidth / 2 + blockPositions[i].dx - 40,
              top: screenHeight / 2 + blockPositions[i].dy,
              child: GestureDetector(
                onPanStart: (_) {
                  draggingIndex = i;
                },
                onPanUpdate: (details) {
                  if (draggingIndex == i) {
                    setState(() {
                      blockPositions[i] =
                          blockPositions[i] + details.delta;
                    });
                  }
                },
                onPanEnd: (_) {
                  draggingIndex = null;
                },
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset("assets/images/main_game/block.png"),
                ),
              ),
            ),

          // Controls: Move Left
          Positioned(
            bottom: 10,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  characterX = (characterX - step).clamp(
                    -screenWidth / 2 + 40,
                    screenWidth / 2 - 40,
                  );
                });
              },
              child: const Icon(Icons.arrow_left),
            ),
          ),

          // Controls: Move Right
          Positioned(
            bottom: 10,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  characterX = (characterX + step).clamp(
                    -screenWidth / 2 + 40,
                    screenWidth / 2 - 40,
                  );
                });
              },
              child: const Icon(Icons.arrow_right),
            ),
          ),
        ],
      ),
    );
  }
}
