import 'package:flutter/material.dart';
import '../presentation/player_info_collection_screen/player_info_collection_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/signup_screen/signup_screen.dart';
import '../presentation/onboarding_video_screen/onboarding_video_screen.dart';
import '../presentation/today_s_discovery_screen/today_s_discovery_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String playerInfoCollection = '/player-info-collection-screen';
  static const String splash = '/splash-screen';
  static const String homeDashboard = '/home-dashboard';
  static const String login = '/login-screen';
  static const String signup = '/signup-screen';
  static const String onboardingVideo = '/onboarding-video-screen';
  static const String todaySDiscovery = '/today-s-discovery-screen';

  // Player info collection screen
  static const String playerInfoCollectionScreen =
      '/player-info-collection-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    playerInfoCollection: (context) => const PlayerInfoCollectionScreen(),
    splash: (context) => const SplashScreen(),
    homeDashboard: (context) => const HomeDashboard(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    onboardingVideo: (context) => const OnboardingVideoScreen(),
    todaySDiscovery: (context) => const TodaySDiscoveryScreen(),
    // TODO: Add your other routes here
  };
}
