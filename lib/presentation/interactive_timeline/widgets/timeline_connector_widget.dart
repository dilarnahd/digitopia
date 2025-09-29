import 'package:flutter/material.dart';

/// Timeline connector widget - long gold connecting line
/// Implements solid gold line instead of circles for visual continuity
class TimelineConnectorWidget extends StatelessWidget {
  final double height;

  const TimelineConnectorWidget({
    super.key,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4, // Increased width for better visibility
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFe5c687), // Gold color
        borderRadius: BorderRadius.circular(2), // Rounded edges
      ),
    );
  }
}
