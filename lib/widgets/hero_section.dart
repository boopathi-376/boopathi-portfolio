import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;
  final ValueChanged<String> onMenuClick;
  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
    required this.onMenuClick,
  });

  @override
  Widget build(BuildContext context) {
    final personalInfo = context.watch<PortfolioProvider>().personalInfo;
    final isWeb = kIsWeb;

    if (personalInfo == null) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isMobile = screenWidth < 900;

        return Container(
          width: screenWidth,
          color: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24.0 : 80.0,
            vertical: 60.0,
          ),
          child: Column(
            children: [
              if (!isMobile)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildTextContent(personalInfo, isWeb),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: _buildProfileImage(personalInfo.imageUrl, isWeb),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildProfileImage(personalInfo.imageUrl, isWeb),
                    const SizedBox(height: 48),
                    _buildTextContent(personalInfo, isWeb, isCenter: true),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextContent(dynamic personalInfo, bool isWeb, {bool isCenter = false}) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          personalInfo.name,
          style: GoogleFonts.lora(
            fontSize: isWeb ? 80 : 48,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          personalInfo.role,
          style: GoogleFonts.inter(
            fontSize: isWeb ? 24 : 20,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          personalInfo.bio,
          textAlign: isCenter ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.lora(
            fontSize: isWeb ? 20 : 18,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 48),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isCenter ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _primaryButton("View Work", onViewWork),
            _secondaryButton("Contact Me", onContact),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage(String? imageUrl, bool isWeb) {
    double size = isWeb ? 400 : 250;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border, width: 1),
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }

  Widget _primaryButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        elevation: 0,
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _secondaryButton(String label, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        side: const BorderSide(color: Colors.black, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
    );
  }
}
