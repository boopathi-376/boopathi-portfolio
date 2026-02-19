import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class InternshipSection extends StatelessWidget {
  const InternshipSection({super.key});

  @override
  Widget build(BuildContext context) {
    final internships = context.watch<PortfolioProvider>().internships;
    final isWeb = MediaQuery.of(context).size.width > 900;

    if (internships.isEmpty) return const SizedBox.shrink();

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
                "Experience",
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
                itemCount: internships.length,
                separatorBuilder:
                    (context, index) =>
                        Divider(color: Colors.white.withOpacity(0.05)),
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

class _InternshipListItem extends StatefulWidget {
  final dynamic internship;
  const _InternshipListItem({required this.internship});

  @override
  State<_InternshipListItem> createState() => _InternshipListItemState();
}

class _InternshipListItemState extends State<_InternshipListItem> {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContent()),
                    const SizedBox(width: 32),
                    _buildDate(widget.internship.date),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContent(),
                    const SizedBox(height: 8),
                    _buildDate(widget.internship.date),
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
          widget.internship.title,
          style: GoogleFonts.inter(
            color: isHover ? AppColors.textPrimary : Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.internship.company,
          style: GoogleFonts.inter(
            color: AppColors.secondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.internship.description,
          style: GoogleFonts.inter(
            color: AppColors.textTertiary,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
