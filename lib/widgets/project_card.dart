import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';
import '../constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = kIsWeb;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                _isHovered
                    ? AppColors.secondary
                    : Colors.white.withOpacity(0.1),
            width: 1.5,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: AppColors.secondary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 0), // Center glow
                spreadRadius: 2,
              ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === TRAFFIC LIGHTS HEADER ===
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.black, // Darker header for terminal feel
              child: Row(
                children: [
                  _circle(const Color(0xFFFF5F56)),
                  const SizedBox(width: 8),
                  _circle(const Color(0xFFFFBD2E)),
                  const SizedBox(width: 8),
                  _circle(const Color(0xFF27C93F)),
                ],
              ),
            ),

            // Project Image
            AspectRatio(
              aspectRatio:
                  isWeb
                      ? 2.0
                      : 1.9, // Increased from 1.7/1.8 to make image shorter
              child: Image.network(
                widget.project.imageUrl,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: AppColors.surface,
                      child: Icon(
                        Icons.code,
                        color: Colors.white.withOpacity(0.1),
                        size: 48,
                      ),
                    ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isWeb ? 16 : 14), // Reduced padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.title,
                      style: GoogleFonts.orbitron(
                        color: AppColors.textPrimary,
                        fontSize: isWeb ? 16 : 14, // Reduced font size
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isWeb ? 8 : 6),
                    // Removed Expanded wrapper to let Text take natural size (limited by maxLines)
                    Text(
                      widget.project.description,
                      style: GoogleFonts.inter(
                        color: AppColors.textSecondary,
                        fontSize: isWeb ? 11 : 10,
                        height: 1.4,
                      ),
                      maxLines: isWeb ? 3 : 3, // Reduced max lines
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isWeb ? 16 : 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children:
                          widget.project.technologies
                              .take(4) // Limit tags to 4
                              .map((tech) => _techChip(tech, isWeb))
                              .toList(),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Wrap(
                        spacing: 12, // Space between buttons
                        children: [
                          if (widget.project.liveDemoUrl != null)
                            _liveDemoButton(widget.project.liveDemoUrl, isWeb),
                          _codeButton(widget.project.githubUrl, isWeb),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _techChip(String label, bool isWeb) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? 10 : 8,
        vertical: isWeb ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.accent.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.firaCode(
          color: AppColors.accent,
          fontSize: isWeb ? 10 : 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> _launchUrl(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Widget _codeButton(String? url, bool isWeb) {
    if (url == null || url.isEmpty) return const SizedBox.shrink();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isWeb ? 16 : 14,
            vertical: isWeb ? 10 : 8,
          ),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.secondary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.secondary, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.terminal,
                color: _isHovered ? Colors.black : AppColors.secondary,
                size: isWeb ? 18 : 16,
              ),
              SizedBox(width: isWeb ? 8 : 6),
              Text(
                "View Code",
                style: GoogleFonts.firaCode(
                  color: _isHovered ? Colors.black : AppColors.secondary,
                  fontSize: isWeb ? 12 : 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _liveDemoButton(String? url, bool isWeb) {
    if (url == null || url.isEmpty) return const SizedBox.shrink();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(
            horizontal: isWeb ? 16 : 14,
            vertical: isWeb ? 10 : 8,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.play_arrow_rounded,
                color: AppColors.primary,
                size: isWeb ? 18 : 16,
              ),
              SizedBox(width: isWeb ? 8 : 6),
              Text(
                "Live Demo",
                style: GoogleFonts.firaCode(
                  color: AppColors.primary,
                  fontSize: isWeb ? 12 : 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
