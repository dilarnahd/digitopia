import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LoginFormWidget extends StatefulWidget {
  final Function(String email, String password) onLogin;
  final bool isLoading;

  const LoginFormWidget({
    super.key,
    required this.onLogin,
    this.isLoading = false,
  });

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isValidEmail(_emailController.text);

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();
      widget.onLogin(_emailController.text.trim(), _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Label
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'البريد الإلكتروني',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF264653), // Dark green text
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: 1.h),

          // Email Field - Enhanced white background with better text contrast
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Pure white background
              borderRadius: BorderRadius.circular(30), // Oval shape
              border: Border.all(
                color: const Color(0xFFD4AF37), // Gold accent
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textDirection: TextDirection.ltr,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(
                  0xFF1B4332,
                ), // Darker green for better contrast
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'أدخل بريدك الإلكتروني',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF264653).withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                  vertical: 2.h,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                if (!_isValidEmail(value)) {
                  return 'يرجى إدخال بريد إلكتروني صحيح';
                }
                // Remove demo account validation - no longer accept حساب تجريبي
                return null;
              },
            ),
          ),

          SizedBox(height: 3.h),

          // Password Label
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'كلمة المرور',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF264653), // Dark green text
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: 1.h),

          // Password Field - Enhanced white background with better text contrast
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // Pure white background
              borderRadius: BorderRadius.circular(30), // Oval shape
              border: Border.all(
                color: const Color(0xFFD4AF37), // Gold accent
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              textInputAction: TextInputAction.done,
              textDirection: TextDirection.ltr,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(
                  0xFF1B4332,
                ), // Darker green for better contrast
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'أدخل كلمة المرور',
                hintStyle: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF264653).withValues(alpha: 0.5),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: const Color(0xFF264653).withValues(alpha: 0.7),
                    size: 20,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                  vertical: 2.h,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال كلمة المرور';
                }
                if (value.length < 6) {
                  return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                }
                return null;
              },
              onFieldSubmitted: (_) => _handleLogin(),
            ),
          ),

          SizedBox(height: 4.h),

          // Login Button
          SizedBox(
            height: 6.h,
            child: ElevatedButton(
              onPressed:
                  _isFormValid && !widget.isLoading ? _handleLogin : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid
                    ? const Color(0xFF264653) // Dark green when enabled
                    : const Color(0xFF264653).withValues(alpha: 0.3),
                foregroundColor: Colors.white,
                elevation: _isFormValid ? 2 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Oval shape for button
                ),
              ),
              child: widget.isLoading
                  ? SizedBox(
                      width: 5.w,
                      height: 5.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    )
                  : Text(
                      'تسجيل الدخول',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
