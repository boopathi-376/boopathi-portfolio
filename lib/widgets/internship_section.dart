import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipSection extends StatelessWidget {
  const InternshipSection({super.key});

  @override
  Widget build(BuildContext context) {
    final internships = context.watch<PortfolioProvider>().internships;
    final isWeb = MediaQuery.of(context).size.width > 900;

    if (internships.isEmpty) return const SizedBox.shrink();

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
                "Experience",
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
                itemCount: internships.length,
                separatorBuilder: (context, index) => const Divider(color: AppColors.border),
                itemBuilder: (context, index) {
                  return _InternshipListItem(internship: internships[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InternshipListItem extends StatelessWidget {
  final dynamic internship;
  const _InternshipListItem({required this.internship});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  internship.title,
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isWeb)
                Text(
                  internship.date,
                  style: GoogleFonts.inter(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            internship.company,
            style: GoogleFonts.inter(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (!isWeb) ...[
            const SizedBox(height: 8),
            Text(
              internship.date,
              style: GoogleFonts.inter(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            internship.description,
            style: GoogleFonts.lora(
              color: AppColors.textSecondary,
              fontSize: 16,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
