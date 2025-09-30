
import 'package:egyptquest/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../../services/supabase_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _fadeAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _screenFadeAnimation;

  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeApp();
  }

  void _initializeAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 240),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _screenFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _logoAnimationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      // Keep all initialization tasks intact
      await Future.wait([
        _checkAuthenticationStatus(),
        _loadArabicFontAssets(),
        _fetchDailyDiscoveryContent(),
        _prepareCachedCulturalData(),
      ]);

      setState(() {
        _isInitialized = true;
      });

      await Future.delayed(const Duration(milliseconds: 2000));

      if (mounted) {
        _navigateToLogin();
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'فشل في تحميل التطبيق. يرجى المحاولة مرة أخرى.';
      });

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && _hasError) {
          _showRetryOption();
        }
      });
    }
  }

  Future<void> _checkAuthenticationStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _loadArabicFontAssets() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _fetchDailyDiscoveryContent() async {
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<void> _prepareCachedCulturalData() async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  Future<void> _navigateToLogin() async {
    // Always navigate to login screen
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  void _showRetryOption() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF264653),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFD4AF37), width: 1),
        ),
        title: const Text(
          'خطأ في التحميل',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          _errorMessage,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _hasError = false;
                _isInitialized = false;
              });
              _initializeApp();
            },
            child: const Text(
              'إعادة المحاولة',
              style: TextStyle(color: Color(0xFFD4AF37)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF264653),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Color(0xFF264653),
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          child: AnimatedBuilder(
            animation: _screenFadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _screenFadeAnimation.value,
                child: SafeArea(
                  child: SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),
                        _buildLogoSection(),
                        SizedBox(height: 8.h),
                        _buildLoadingIndicator(),
                        const Spacer(flex: 3),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: _logoAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScaleAnimation.value,
          child: Opacity(
            opacity: _logoFadeAnimation.value,
            child: Column(
              children: [
                Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/images/logo-1758648320376.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              color: Color(0xFF264653),
                              size: 50,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                const Text(
                  'اللي كان و اللي هيكون',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    if (_hasError) {
      return Column(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFD4AF37), size: 48),
          SizedBox(height: 2.h),
          const Text(
            'حدث خطأ في التحميل',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
            backgroundColor: const Color(0xFFD4AF37).withValues(alpha: 0.2),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          _isInitialized ? 'جاري التحميل...' : 'تحضير المحتوى...',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
