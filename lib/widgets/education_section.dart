import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final education = context.watch<PortfolioProvider>().education;
    final theme = Theme.of(context);
    final isWeb = MediaQuery.of(context).size.width > 900;

    if (education.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
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
                "Education",
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
                itemCount: education.length,
                separatorBuilder:
                    (context, index) =>
                        Divider(color: Colors.white.withOpacity(0.05)),
                itemBuilder: (context, index) {
                  return _EducationListItem(edu: education[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EducationListItem extends StatefulWidget {
  final dynamic edu;
  const _EducationListItem({required this.edu});

  @override
  State<_EducationListItem> createState() => _EducationListItemState();
}

class _EducationListItemState extends State<_EducationListItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    final theme = Theme.of(context);

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
                    Expanded(child: _buildContent(theme)),
                    const SizedBox(width: 32),
                    _buildDate(widget.edu.date),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContent(theme),
                    const SizedBox(height: 8),
                    _buildDate(widget.edu.date),
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

  Widget _buildContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.edu.title,
          style: GoogleFonts.inter(
            color: isHover ? AppColors.textPrimary : Colors.white70,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        if (widget.edu.subtitle != null) ...[
          Text(
            widget.edu.subtitle!,
            style: GoogleFonts.inter(
              color: Colors.white60,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
        ],
        Text(
          widget.edu.institution,
          style: GoogleFonts.inter(color: AppColors.textTertiary, fontSize: 14),
        ),
        if (widget.edu.score != null) ...[
          const SizedBox(height: 4),
          Text(
            widget.edu.score!,
            style: GoogleFonts.firaCode(
              color: AppColors.secondary.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }
}
