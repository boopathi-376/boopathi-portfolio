import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_card.dart';

class ProjectGrid extends StatelessWidget {
  const ProjectGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<PortfolioProvider>().projects;
    final isWeb = kIsWeb;

    if (projects.isEmpty) {
      return const Center(
        child: Text(
          "No projects found.",
          style: TextStyle(color: Colors.black54),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final horizontalPadding =
            screenWidth > 1200
                ? 80.0
                : screenWidth > 800
                ? 60.0
                : 24.0;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  "Featured Projects",
                  style: GoogleFonts.lora(
                    color: AppColors.textPrimary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: isWeb ? 460 : 430,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  itemCount: projects.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 32),
                  itemBuilder: (context, index) {
                    return ProjectCard(project: projects[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
