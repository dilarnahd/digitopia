import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom AppBar widget implementing Academic Heritage design with RTL support
/// Provides clean header implementation with strategically placed navigation
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final PreferredSizeWidget? bottom;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.elevation = 2.0,
    this.backgroundColor,
    this.foregroundColor,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.amiri(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: foregroundColor ?? (isDark ? Colors.white : Colors.white),
        ),
      ),
      actions: actions ?? _buildDefaultActions(context),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor ??
          (isDark ? const Color(0xFF2D2D2D) : const Color(0xFF2F5F5F)),
      foregroundColor: foregroundColor ?? Colors.white,
      iconTheme: IconThemeData(
        color: foregroundColor ?? Colors.white,
        size: 24,
      ),
      bottom: bottom,
      // RTL support
      titleSpacing: 0,
    );
  }

  /// Build default actions for the app bar
  List<Widget> _buildDefaultActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.timeline),
        tooltip: 'Interactive Timeline',
        onPressed: () {
          Navigator.pushNamed(context, '/interactive-timeline');
        },
      ),
      IconButton(
        icon: const Icon(Icons.more_vert),
        tooltip: 'More options',
        onPressed: () {
          _showMoreOptions(context);
        },
      ),
    ];
  }

  /// Show more options menu
  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.timeline),
              title: Text(
                'Interactive Timeline',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/interactive-timeline');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'Settings',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Add settings navigation when available
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text(
                'About',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // Add about navigation when available
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );
}
