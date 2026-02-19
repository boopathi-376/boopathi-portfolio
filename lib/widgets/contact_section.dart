import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
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
    final isWeb = kIsWeb; // Breakpoint handled inside LayoutBuilder

    if (personalInfo == null) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isWide = screenWidth > 900;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: AppDimensions.paddingSectionWeb,
            horizontal: isWide ? 60 : 24,
          ),
          color: Colors.black,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Text(
                    "INITIALIZE_CONNECTION",
                    style: GoogleFonts.firaCode(
                      color: AppColors.secondary,
                      fontSize: 14,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Let's Build Something\nExceptional Together.",
                    style: GoogleFonts.orbitron(
                      color: AppColors.textPrimary,
                      fontSize: isWide ? 52 : 36,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 60),

                  /// SPLIT LAYOUT OR STACK
                  isWide
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              "I'm currently available for freelance projects and open to full-time opportunities. If you have a project that needs some creative injection, let's chat.",
                              style: GoogleFonts.inter(
                                color: AppColors.textSecondary,
                                fontSize: 18,
                                height: 1.6,
                              ),
                            ),
                          ),
                          const SizedBox(width: 80),
                          Expanded(
                            flex: 5,
                            child: _buildLinksColumn(personalInfo, isWide),
                          ),
                        ],
                      )
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "I'm currently available for freelance projects and open to full-time opportunities.",
                            style: GoogleFonts.inter(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 40),
                          _buildLinksColumn(personalInfo, isWide),
                        ],
                      ),

                  const SizedBox(height: 30),
                  Divider(color: Colors.white.withOpacity(0.1)),
                  const SizedBox(height: 20),

                  /// FOOTER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "© ${DateTime.now().year} ${personalInfo.name}.",
                        style: GoogleFonts.inter(
                          color: AppColors.textTertiary,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Flutter Web Portfolio",
                        style: GoogleFonts.inter(
                          color: AppColors.textTertiary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLinksColumn(dynamic personalInfo, bool isWide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ContactActionRow(
          label: "Email Me",
          value: personalInfo.email,
          icon: Icons.arrow_outward,
          onTap: () => _launchUrl("mailto:${personalInfo.email}"),
          isHighlight: true,
        ),
        const SizedBox(height: 16),
        _ContactActionRow(
          label: "LinkedIn",
          value: "Connect",
          icon: Icons.link,
          onTap: () => _launchUrl(personalInfo.socialLinks['LinkedIn'] ?? ''),
        ),
        const SizedBox(height: 16),
        _ContactActionRow(
          label: "GitHub",
          value: "View Code",
          icon: Icons.code,
          onTap: () => _launchUrl(personalInfo.socialLinks['GitHub'] ?? ''),
        ),
      ],
    );
  }
}

class _ContactActionRow extends StatefulWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  final bool isHighlight;

  const _ContactActionRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
    this.isHighlight = false,
  });

  @override
  State<_ContactActionRow> createState() => _ContactActionRowState();
}

class _ContactActionRowState extends State<_ContactActionRow> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 30),
          decoration: BoxDecoration(
            color:
                isHover || widget.isHighlight
                    ? Colors.white
                    : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(
              0,
            ), // Sharp edges for terminal feel
            border: Border.all(
              color:
                  isHover || widget.isHighlight
                      ? Colors.white
                      : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: GoogleFonts.inter(
                      color:
                          isHover || widget.isHighlight
                              ? Colors.black
                              : Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.value,
                    style: GoogleFonts.orbitron(
                      color:
                          isHover || widget.isHighlight
                              ? Colors.black
                              : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Icon(
                widget.icon,
                color:
                    isHover || widget.isHighlight ? Colors.black : Colors.white,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
