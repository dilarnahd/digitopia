import '../library_screen/Library-screen.dart';

import '../interactive_timeline/interactive_timeline.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../services/supabase_service.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  String _playerName = 'ضيف';
  bool _hasStartedJourney = false;
  final SupabaseService _supabaseService = SupabaseService.instance;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }

  Future<void> _loadPlayerData() async {
    try {
      final name = await _supabaseService.getPlayerName();
      final journeyStarted = await _supabaseService.hasUserStartedJourney();

      if (mounted) {
        setState(() {
          _playerName = name;
          _hasStartedJourney = journeyStarted;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _onJourneyButtonPressed() async {
    try {
      if (!_hasStartedJourney) {
        await _supabaseService.updateJourneyStatus(true);
        setState(() {
          _hasStartedJourney = true;
        });
      }
      Navigator.pushNamed(context, AppRoutes.onboardingVideo);
    } catch (e) {
      print('Error starting journey: $e');
    }
  }

  
  void _onNavigationTap(String destination) {
  switch (destination) {
    case 'library':
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LibraryScreen()),
    );
    break;

    case 'discovery':
      Navigator.pushNamed(context, AppRoutes.todaySDiscovery);
      break;
    case 'chatbot':
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الذكاء الاصطناعي قريبًا')),
      );
      break;
    case 'timeline':
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const InteractiveTimeline()),
      );
      break;
  }
}


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppTheme.secondaryLight,
        body: Center(
          child: CircularProgressIndicator(
            color: AppTheme.accentLight,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.secondaryLight,
      body: Column(
        children: [
          // Top curved section with player/settings buttons and welcome message
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.w),
                bottomRight: Radius.circular(30.w),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                child: Column(
                  children: [
                    // Top buttons row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Player button
                        GestureDetector(
                          onTap: () {
                            // Navigate to player account screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('حساب اللاعب قريبًا')),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: AppTheme.accentLight,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.person,
                              color: AppTheme.primaryLight,
                              size: 6.w,
                            ),
                          ),
                        ),
                        // Settings button
                        GestureDetector(
                          onTap: () {
                            // Navigate to settings screen
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('الإعدادات قريبًا')),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: AppTheme.accentLight,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.settings,
                              color: AppTheme.primaryLight,
                              size: 6.w,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    // Welcome message
                    Text(
                      'اهلا بيك $_playerName في رحلتك لاكتشاف حضارتك . أصلك و تاريخك',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Big glowing journey button
                GestureDetector(
                  onTap: _onJourneyButtonPressed,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: AppTheme.accentLight,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.accentLight.withAlpha(102),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Text(
                      _hasStartedJourney
                          ? 'يلا تكمل رحلتك'
                          : 'أبدأ رحلتك عبر تاريخ مصر',
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom curved section with navigation buttons
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.w),
                topRight: Radius.circular(35.w),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Library button
                  _buildNavigationButton(
                    icon: Icons.menu_book,
                    onTap: () => _onNavigationTap('library'),
                  ),

                  // Today's discovery button
                  _buildNavigationButton(
                    icon: Icons.auto_awesome,
                    onTap: () => _onNavigationTap('discovery'),
                  ),

                  // Chatbot button
                  _buildNavigationButton(
                    icon: Icons.chat_bubble_outline,
                    onTap: () => _onNavigationTap('chatbot'),
                  ),

                  // Timeline button
                  _buildNavigationButton(
                    icon: Icons.timeline,
                    onTap: () => _onNavigationTap('timeline'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 15.w,
        height: 15.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.accentLight, width: 2),
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppTheme.accentLight,
            size: 7.w,
          ),
        ),
      ),
    );
  }
}
