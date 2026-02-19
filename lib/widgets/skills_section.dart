import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<PortfolioProvider>().skillCategories;
    final theme = Theme.of(context);

    if (categories.isEmpty) {
      if (Provider.of<PortfolioProvider>(context).isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return const Center(
        child: Text(
          "No skills data loaded",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Container(
      width: double.infinity,
      // Increased vertical padding for better section breathing room
      // Standardized padding
      padding: EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSectionWeb,
        horizontal: MediaQuery.of(context).size.width > 900 ? 60 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Text(
                "Skills & Technologies",
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "The building blocks of my digital solutions.",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 60),

              /// RESPONSIVE GRID
              LayoutBuilder(
                builder: (context, constraints) {
                  // We use a Wrap instead of GridView to avoid fixed height constraints
                  return Wrap(
                    spacing: 30,
                    runSpacing: 30,
                    children:
                        categories.asMap().entries.map((entry) {
                          int index = entry.key;
                          var category = entry.value;

                          // Calculate width based on screen size
                          double cardWidth = (constraints.maxWidth - 30) / 2;
                          if (constraints.maxWidth < 800) {
                            cardWidth = constraints.maxWidth;
                          }

                          return SizedBox(
                                width: cardWidth,
                                child: _SkillCard(category: category),
                              )
                              .animate(delay: (100 * index).ms)
                              .fadeIn(duration: 500.ms)
                              .slideY(begin: 0.1, curve: Curves.easeOut);
                        }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillCard extends StatefulWidget {
  final dynamic category;
  const _SkillCard({required this.category});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool isHover = false;

  IconData _getIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains("mobile")) return Icons.stay_primary_portrait_rounded;
    if (t.contains("backend")) return Icons.terminal_rounded;
    if (t.contains("database")) return Icons.dns_rounded;
    if (t.contains("tool")) return Icons.architecture_rounded;
    if (t.contains("language")) return Icons.code;
    return Icons.category_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final skills = (widget.category.skills as List<String>);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color:
              isHover
                  ? AppColors.card.withOpacity(0.4)
                  : AppColors.background.withOpacity(0.3),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color:
                isHover ? AppColors.secondary : Colors.white.withOpacity(0.05),
            width: isHover ? 2 : 1,
          ),
          boxShadow: [
            if (isHover)
              BoxShadow(
                color: AppColors.secondary.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.secondary.withOpacity(0.2),
                    ),
                  ),
                  child: Icon(
                    _getIcon(widget.category.title),
                    color: AppColors.secondary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.category.title,
                    style: GoogleFonts.orbitron(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  skills.map((skill) => _SkillChip(label: skill)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  const _SkillChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(4), // Tech-tag shape
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.2)),
      ),
      child: Text(
        label,
        style: GoogleFonts.firaCode(
          color: AppColors.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
