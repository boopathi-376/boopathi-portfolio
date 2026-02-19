import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import '../providers/portfolio_provider.dart';
import '../constants/app_dimensions.dart';
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
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: AppDimensions.paddingSectionWeb,
            horizontal: screenWidth > 900 ? 60 : 24,
          ),
          color: Colors.black,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Featured Projects",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          screenWidth > 1200
                              ? 46
                              : (screenWidth > 600 ? 38 : 30),
                      fontWeight: FontWeight.bold,
                      letterSpacing: isWeb ? -0.5 : 0.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: isWeb ? 20 : 16),
                  Text(
                    "Explore some of my recent projects and their features",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: screenWidth > 600 ? 16 : 14,
                      height: 1.6,
                      letterSpacing: isWeb ? 0.1 : 0.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: isWeb ? 100 : 80),
                  SizedBox(
                    height: 500, // Fixed height for the card container
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: projects.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(width: 30),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: isWeb ? 400 : 320, // Fixed width for each card
                          child: ProjectCard(project: projects[index]),
                        );
                      },
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
}
