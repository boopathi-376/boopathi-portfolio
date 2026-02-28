import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final personalInfo = context.watch<PortfolioProvider>().personalInfo;
    final isWeb = kIsWeb;

    if (personalInfo == null) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isWide = screenWidth > 900;

        return Container(
          width: double.infinity,
          color: AppColors.background,
          padding: EdgeInsets.symmetric(
            vertical: 60,
            horizontal: isWide ? 80 : 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Text(
                    "Get in Touch",
                    style: GoogleFonts.lora(
                      color: AppColors.textPrimary,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "I'm always open to new opportunities and collaborations. Whether you have a project in mind or just want to say hi, feel free to reach out.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                      color: AppColors.textSecondary,
                      fontSize: 20,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 60),
                  _buildContactLink("Email", personalInfo.email, "mailto:${personalInfo.email}"),
                  _buildContactLink("LinkedIn", "Connect on LinkedIn", personalInfo.socialLinks['LinkedIn'] ?? ""),
                  _buildContactLink("GitHub", "View Git Projects", personalInfo.socialLinks['GitHub'] ?? ""),
                  const SizedBox(height: 100),
                  const Divider(color: AppColors.border),
                  const SizedBox(height: 40),
                  Text(
                    "© ${DateTime.now().year} ${personalInfo.name}. All rights reserved.",
                    style: GoogleFonts.inter(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactLink(String label, String value, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () => _launchUrl(url),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$label: ",
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.inter(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
