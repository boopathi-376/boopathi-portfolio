import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CertificationSection extends StatelessWidget {
  const CertificationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final certifications = context.watch<PortfolioProvider>().certifications;
    final isWeb = MediaQuery.of(context).size.width > 900;

    if (certifications.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        vertical: 40,
        horizontal: isWeb ? 80 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Certifications & Achievements",
                style: GoogleFonts.lora(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: certifications.length,
                separatorBuilder: (context, index) => const Divider(color: AppColors.border),
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

class _CertListItem extends StatelessWidget {
  final dynamic cert;
  const _CertListItem({required this.cert});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cert.title,
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  cert.institution,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          if (isWeb)
            Text(
              cert.date,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}
