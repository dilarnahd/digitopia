import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../services/supabase_service.dart';
import '../login_screen/widgets/app_logo_widget.dart';
import './widgets/signup_form_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> _handleSignup(String name, String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Use Supabase authentication with proper full_name in metadata
      final response = await SupabaseService.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': name,
        },
      );

      if (response.user != null) {
        // Wait a moment for the trigger to create the user profile
        await Future.delayed(const Duration(milliseconds: 500));

        // Verify profile was created, if not create it manually
        try {
          final profile = await SupabaseService.instance.getUserProfile();
          if (profile == null) {
            // Manually create profile if trigger failed
            await SupabaseService.instance.createUserProfile(
              userId: response.user!.id,
              email: email,
              fullName: name,
            );
          }
        } catch (e) {
          // If profile creation/check fails, create manually
          await SupabaseService.instance.createUserProfile(
            userId: response.user!.id,
            email: email,
            fullName: name,
          );
        }

        // Success - navigate to player info collection screen
        HapticFeedback.heavyImpact();

        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.playerInfoCollection,
          );
        }
      }
    } catch (error) {
      // Show error message
      if (mounted) {
        String errorMessage = 'خطأ في إنشاء الحساب';

        // Handle specific error types
        if (error.toString().contains('User already registered')) {
          errorMessage = 'هذا البريد الإلكتروني مستخدم بالفعل';
        } else if (error.toString().contains('Invalid email')) {
          errorMessage = 'بريد إلكتروني غير صحيح';
        } else if (error.toString().contains('Password should be at least')) {
          errorMessage = 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: GoogleFonts.inter(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(4.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5C687),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // App Logo Section with golden accents
                        const AppLogoWidget(),

                        SizedBox(height: 4.h),

                        // Signup Form
                        SignupFormWidget(
                          onSignup: _handleSignup,
                          isLoading: _isLoading,
                        ),

                        SizedBox(height: 2.h),

                        // Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'لديك حساب؟ ',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: const Color(0xFF264653),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                              },
                              child: Text(
                                'تسجيل الدخول',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF264653),
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  decorationColor: const Color(0xFF264653),
                                ),
                              ),
                            ),
                          ],
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
}
