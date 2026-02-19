import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  final Function(String) onMenuClick; // Single callback for all nav

  const HeroSection({super.key, required this.onMenuClick});

  @override
  Widget build(BuildContext context) {
    final personalInfo = context.watch<PortfolioProvider>().personalInfo;
    final theme = Theme.of(context);
    final isWeb = kIsWeb;

    if (personalInfo == null) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = MediaQuery.of(context).size.height;
        final isMobile = screenWidth < 900;

        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  backgroundBlendMode: BlendMode.srcOver,
                ),
              ),
            ),
            Positioned(
              top: -screenHeight * 0.2,
              right: -screenWidth * 0.1,
              child: Container(
                    width: screenWidth * 0.6,
                    height: screenWidth * 0.6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.15),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.7],
                        radius: 0.6,
                      ),
                    ),
                  )
                  .animate()
                  .scale(
                    duration: 3.seconds,
                    curve: Curves.easeInOut,
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.1, 1.1),
                  )
                  .then()
                  .scale(
                    duration: 3.seconds,
                    curve: Curves.easeInOut,
                    begin: const Offset(1.1, 1.1),
                    end: const Offset(0.8, 0.8),
                  )
                  .listen(callback: (value) {}), // Loop placeholder
            ),

            /// 2. CONTENT
            Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: screenHeight),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      isMobile ? 24 : 60,
                      24,
                      isMobile ? 24 : 60,
                      40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// ================= NAVBAR =================
                        _buildNavBar(context, personalInfo, isMobile),

                        if (isMobile)
                          const SizedBox(height: 20)
                        else
                          const SizedBox(height: 60),

                        /// ================= HERO CONTENT =================
                        if (!isMobile)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 600,
                                    ),
                                    child: _buildTextContent(
                                      personalInfo,
                                      theme,
                                      isWeb,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: _buildProfileImage(
                                        personalInfo.imageUrl,
                                        screenWidth,
                                      )
                                      .animate()
                                      .fadeIn(duration: 800.ms)
                                      .slideX(
                                        begin: 0.1,
                                        end: 0,
                                        curve: Curves.easeOutBack,
                                      ),
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildProfileImage(
                                personalInfo.imageUrl,
                                screenWidth,
                              ).animate().fadeIn(duration: 800.ms).scale(),
                              const SizedBox(height: 30),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 500,
                                ),
                                child: _buildTextContent(
                                  personalInfo,
                                  theme,
                                  isWeb,
                                  isCenter: true,
                                ),
                              ),
                            ],
                          ),

                        // Removed Arrow and large spacer
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// ================= NAV BAR =================

  Widget _buildNavBar(
    BuildContext context,
    dynamic personalInfo,
    bool isMobile,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${personalInfo.name}.",
          style: GoogleFonts.orbitron(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            shadows: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(),
        if (isMobile)
          IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
          )
        else
          _buildDesktopNav(),
      ],
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      children: [
        const SizedBox(width: 28),
        _navItem("Skills"),
        const SizedBox(width: 28),
        _navItem("Experience"), // Added
        const SizedBox(width: 28),
        _navItem("Education"),
        const SizedBox(width: 28),
        _navItem("Certifications"), // Added
        const SizedBox(width: 28),
        _navItem("Projects"),
        const SizedBox(width: 28),
        _navItem("Contact"),
      ],
    );
  }

  Widget _navItem(String title) {
    return GestureDetector(
      onTap: () => onMenuClick(title),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// ================= TEXT CONTENT =================

  Widget _buildTextContent(
    dynamic personalInfo,
    ThemeData theme,
    bool isWeb, {
    bool isCenter = false,
  }) {
    return Column(
      crossAxisAlignment:
          isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "SYSTEM ONLINE //",
          style: GoogleFonts.firaCode(
            color: AppColors.secondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.0,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5),

        const SizedBox(height: 12),

        Text(
          "Welcome to My Portfolio",
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.orbitron(
            color: AppColors.textPrimary,
            fontSize: isCenter ? 36 : 62,
            fontWeight: FontWeight.w900,
            height: 1.1,
            letterSpacing: -1.0,
            shadows: [
              BoxShadow(
                color: AppColors.background.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 0,
              ),
            ],
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
        const SizedBox(height: 20),

        RichText(
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: 18,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            children: [
              const TextSpan(text: "Hi, I'm "),
              TextSpan(
                text: personalInfo.name,
                style: GoogleFonts.inter(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: " — Flutter Developer 🚀"),
            ],
          ),
        ).animate().fadeIn(delay: 600.ms),

        const SizedBox(height: 28),

        Text(
          personalInfo.bio,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.inter(
            color: AppColors.textTertiary,
            fontSize: 16,
            height: 1.6,
          ),
        ).animate().fadeIn(delay: 800.ms),

        const SizedBox(height: 36),

        Wrap(
          spacing: 18,
          runSpacing: 18,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _primaryButton(
              "View My Work",
              () => onMenuClick('Projects'), // Use callback
            ),
            _secondaryButton("Download Resume"),
          ],
        ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2),

        const SizedBox(height: 36),

        Wrap(
          spacing: 18,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _socialIcon(Icons.code),
            _socialIcon(Icons.work),
            _socialIcon(Icons.email),
          ],
        ).animate().fadeIn(delay: 1200.ms),
      ],
    );
  }

  /// ================= PROFILE IMAGE =================

  Widget _buildProfileImage(String? imageUrl, double screenWidth) {
    double size =
        screenWidth > 1200
            ? 360
            : screenWidth > 800
            ? 300
            : 220;

    ImageProvider? imageProvider;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
        imageProvider = NetworkImage(imageUrl);
      } else {
        imageProvider = AssetImage(imageUrl);
      }
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 80,
            spreadRadius: 20,
          ),
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
        image:
            imageProvider != null
                ? DecorationImage(image: imageProvider, fit: BoxFit.cover)
                : null,
      ),
    );
  }

  /// ================= BUTTONS =================

  Widget _primaryButton(String label, VoidCallback onPressed) {
    return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                label,
                style: GoogleFonts.inter(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
        .animate(target: 1)
        .scaleXY(end: 1.05, duration: 200.ms, curve: Curves.easeOut);
  }

  Widget _secondaryButton(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
        side: const BorderSide(color: AppColors.secondary, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
        ),
      ),
    );
  }

  /// ================= SOCIAL ICON =================

  Widget _socialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Icon(icon, color: Colors.white70, size: 24),
    );
  }
}
