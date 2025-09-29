import 'package:flutter/material.dart';
import '../presentation/interactive_timeline/interactive_timeline.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String interactiveTimeline = '/interactive-timeline';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const InteractiveTimeline(),
    interactiveTimeline: (context) => const InteractiveTimeline(),
    // TODO: Add your other routes here
  };
}