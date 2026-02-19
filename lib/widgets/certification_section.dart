import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class CertificationSection extends StatelessWidget {
  const CertificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final certifications = context.watch<PortfolioProvider>().certifications;
    final isWeb = MediaQuery.of(context).size.width > 900;

    if (certifications.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 60 : 24,
        vertical:
            isWeb
                ? AppDimensions.paddingSectionWeb
                : AppDimensions.paddingSectionMobile,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Certifications & Achievements",
                style: GoogleFonts.orbitron(
                  color: AppColors.textPrimary,
                  fontSize: isWeb ? 30 : 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 40),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: certifications.length,
                separatorBuilder:
                    (context, index) =>
                        Divider(color: Colors.white.withOpacity(0.05)),
                itemBuilder: (context, index) {
                  return _CertListItem(cert: certifications[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CertListItem extends StatefulWidget {
  final dynamic cert;
  const _CertListItem({required this.cert});

  @override
  State<_CertListItem> createState() => _CertListItemState();
}

class _CertListItemState extends State<_CertListItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color:
              isHover
                  ? AppColors.primary.withOpacity(0.05)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            left: BorderSide(
              color: isHover ? AppColors.accent : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child:
            isWeb
                ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _buildContent()),
                    const SizedBox(width: 32),
                    _buildDate(widget.cert.date),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContent(),
                    const SizedBox(height: 8),
                    _buildDate(widget.cert.date),
                  ],
                ),
      ),
    );
  }

  Widget _buildDate(String date) {
    return Text(
      "[$date]",
      style: GoogleFonts.firaCode(
        color: isHover ? AppColors.accent : AppColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.cert.title,
          style: GoogleFonts.inter(
            color: isHover ? AppColors.textPrimary : Colors.white70,
            fontSize: 16, // Already reduced size
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.cert.institution,
          style: GoogleFonts.inter(
            color: AppColors.textTertiary,
            fontSize: 14, // Already reduced size
          ),
        ),
      ],
    );
  }
}
